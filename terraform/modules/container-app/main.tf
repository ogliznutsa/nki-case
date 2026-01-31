resource "azurerm_container_app" "this" {
  name                         = var.name
  container_app_environment_id = var.container_app_environment_id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  identity {
    type         = "UserAssigned"
    identity_ids = var.user_assigned_identity_ids
  }

  template {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    container {
      name   = var.container_name
      image  = var.image
      cpu    = var.cpu
      memory = var.memory

      env {
        name  = "AZURE_AD_CLIENT_ID"
        value = var.azure_ad_client_id
      }

      env {
        name        = "AZURE_AD_CLIENT_SECRET"
        secret_name = "azure-ad-client-secret"
      }

      env {
        name  = "AZURE_AD_TENANT_ID"
        value = var.azure_ad_tenant_id
      }

      env {
        name  = "NEXTAUTH_URL"
        value = var.nextauth_url
      }

      env {
        name        = "NEXTAUTH_SECRET"
        secret_name = "nextauth-secret"
      }

      env {
        name  = "AUTH_TRUST_HOST"
        value = "true"
      }
    }
  }

  secret {
    name                = "azure-ad-client-secret"
    key_vault_secret_id = var.azure_ad_client_secret_kv_id
    identity            = var.user_assigned_identity_ids[0]
  }

  secret {
    name                = "nextauth-secret"
    key_vault_secret_id = var.nextauth_secret_kv_id
    identity            = var.user_assigned_identity_ids[0]
  }

  ingress {
    external_enabled = true
    target_port      = 3000

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  registry {
    server   = var.registry_server
    identity = var.user_assigned_identity_ids[0]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [template[0].container[0].image]
  }
}
