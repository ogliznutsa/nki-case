output "resource_group_id" {
  description = "The ID of the resource group"
  value       = module.resource_group.id
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.resource_group.name
}

output "key_vault_id" {
  description = "The ID of the Key Vault"
  value       = module.key_vault.id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault"
  value       = module.key_vault.uri
}

output "key_vault_name" {
  description = "The name of the Key Vault"
  value       = module.key_vault.name
}

output "container_app_environment_id" {
  description = "The ID of the Container App Environment"
  value       = module.container_app_environment.id
}

output "container_app_environment_default_domain" {
  description = "The default domain of the Container App Environment"
  value       = module.container_app_environment.default_domain
}

output "app_client_id" {
  description = "The Application (Client) ID for Azure AD"
  value       = module.app_registration.client_id
}

output "app_object_id" {
  description = "The Object ID of the application"
  value       = module.app_registration.object_id
}

output "app_client_secret" {
  description = "The application client secret"
  value       = module.app_registration.client_secret
  sensitive   = true
}

output "b2b_users_group_id" {
  description = "The Object ID of the B2B External Users group"
  value       = module.azuread_groups.b2b_users_group_id
}

output "acr_login_server" {
  description = "The login server for the Container Registry"
  value       = module.container_registry.login_server
}

output "acr_name" {
  description = "The name of the Container Registry"
  value       = module.container_registry.name
}

output "container_app_fqdn" {
  description = "The FQDN of the Container App"
  value       = module.container_app.fqdn
}

output "container_app_url" {
  description = "The full URL of the Container App"
  value       = "https://${module.container_app.fqdn}"
}

output "nextauth_secret" {
  description = "Generated NEXTAUTH_SECRET"
  value       = random_password.nextauth_secret.result
  sensitive   = true
}

output "acr_id" {
  description = "ACR ID for role assignments"
  value       = module.container_registry.id
}

output "container_app_identity_id" {
  description = "Container App user-assigned managed identity ID"
  value       = azurerm_user_assigned_identity.container_app.id
}

output "container_app_identity_principal_id" {
  description = "Container App user-assigned managed identity principal ID"
  value       = azurerm_user_assigned_identity.container_app.principal_id
}
