resource "azuread_application" "app" {
  display_name = "nki-b2b-app-${var.environment}"

  web {
    redirect_uris = var.redirect_uris

    implicit_grant {
      id_token_issuance_enabled = true
    }
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }
}

resource "azuread_application_password" "app_password" {
  application_id = azuread_application.app.id
  display_name   = "Terraform Managed Secret"
  end_date       = timeadd(timestamp(), "8760h") # 1 year

  lifecycle {
    ignore_changes = [end_date]
  }
}

resource "azuread_service_principal" "app_sp" {
  client_id = azuread_application.app.client_id
}
