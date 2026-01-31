locals {
  resource_prefix = "${var.project_name}-${var.environment}"
  common_tags = merge(var.tags, {
    Environment = var.environment
    ManagedBy   = "Terraform"
  })
  # Compute expected FQDN for Container App to avoid circular dependency
  container_app_fqdn = "nki-app-${var.environment}.${module.container_app_environment.default_domain}"
}

module "resource_group" {
  source = "../../modules/resource-group"

  name     = "rg-${local.resource_prefix}"
  location = var.location
  tags     = local.common_tags
}

module "key_vault" {
  source = "../../modules/key-vault"

  name                     = "kv-${var.project_name}-${var.environment}"
  location                 = module.resource_group.location
  resource_group_name      = module.resource_group.name
  sku_name                 = "standard"
  purge_protection_enabled = var.key_vault_purge_protection
  tags                     = local.common_tags
}

module "container_app_environment" {
  source = "../../modules/container-app-environment"

  name                = "cae-${local.resource_prefix}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  log_retention_days  = var.log_retention_days
  tags                = local.common_tags
}

module "container_registry" {
  source = "../../modules/container-registry"

  name                = "acr${var.project_name}${var.environment}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  sku                 = "Basic"
  admin_enabled       = true
  tags                = local.common_tags
}

module "app_registration" {
  source = "../../modules/app-registration"

  environment = var.environment
  redirect_uris = [
    "https://${local.container_app_fqdn}/api/auth/callback/microsoft-entra-id",
    "http://localhost:3000/api/auth/callback/microsoft-entra-id"
  ]
}

module "azuread_groups" {
  source = "../../modules/azuread-groups"

  environment = var.environment
}

# Data source for tenant ID
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_secret" "app_client_secret" {
  name         = "app-client-secret"
  value        = module.app_registration.client_secret
  key_vault_id = module.key_vault.id

  depends_on = [module.key_vault]
}

# Generate NEXTAUTH_SECRET
resource "random_password" "nextauth_secret" {
  length  = 32
  special = true
}

# Store NEXTAUTH_SECRET in Key Vault
resource "azurerm_key_vault_secret" "nextauth_secret" {
  name         = "nextauth-secret"
  value        = random_password.nextauth_secret.result
  key_vault_id = module.key_vault.id

  depends_on = [module.key_vault]
}

# User-assigned managed identity for Container App
resource "azurerm_user_assigned_identity" "container_app" {
  name                = "id-${local.resource_prefix}-app"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags                = local.common_tags
}

# Role assignment for Container App identity to pull images from ACR
resource "azurerm_role_assignment" "container_app_acr_pull_user" {
  scope                = module.container_registry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.container_app.principal_id

  depends_on = [
    azurerm_user_assigned_identity.container_app,
    module.container_registry
  ]
}

# Key Vault access policy for Container App identity
resource "azurerm_key_vault_access_policy" "container_app_identity" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.container_app.principal_id

  secret_permissions = [
    "Get",
    "List",
  ]

  depends_on = [
    azurerm_user_assigned_identity.container_app,
    module.key_vault
  ]
}

# Container App Module
module "container_app" {
  source = "../../modules/container-app"

  name                         = "nki-app-${var.environment}"
  resource_group_name          = module.resource_group.name
  container_app_environment_id = module.container_app_environment.id

  # Image will be updated after first deployment
  image = "${module.container_registry.login_server}/nki-app:${var.app_image_tag}"

  azure_ad_client_id           = module.app_registration.client_id
  azure_ad_client_secret_kv_id = azurerm_key_vault_secret.app_client_secret.versionless_id
  azure_ad_tenant_id           = data.azurerm_client_config.current.tenant_id

  # NEXTAUTH_URL uses computed FQDN
  nextauth_url          = "https://${local.container_app_fqdn}"
  nextauth_secret_kv_id = azurerm_key_vault_secret.nextauth_secret.versionless_id

  # ACR server
  registry_server = module.container_registry.login_server

  # User-assigned identity
  user_assigned_identity_ids = [azurerm_user_assigned_identity.container_app.id]

  tags = local.common_tags

  depends_on = [
    module.container_registry,
    module.app_registration,
    module.key_vault,
    azurerm_user_assigned_identity.container_app,
    azurerm_role_assignment.container_app_acr_pull_user,
    azurerm_key_vault_access_policy.container_app_identity
  ]
}
