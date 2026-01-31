output "application_id" {
  description = "The Application (Client) ID"
  value       = azuread_application.app.client_id
}

output "client_id" {
  description = "Alias for application_id"
  value       = azuread_application.app.client_id
}

output "object_id" {
  description = "The Object ID of the application"
  value       = azuread_application.app.object_id
}

output "client_secret" {
  description = "The application client secret"
  value       = azuread_application_password.app_password.value
  sensitive   = true
}

output "service_principal_id" {
  description = "The Object ID of the service principal"
  value       = azuread_service_principal.app_sp.id
}

output "service_principal_object_id" {
  description = "The Object ID of the service principal"
  value       = azuread_service_principal.app_sp.object_id
}
