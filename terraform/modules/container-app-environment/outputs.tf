output "id" {
  description = "The ID of the Container App Environment"
  value       = azurerm_container_app_environment.this.id
}

output "default_domain" {
  description = "The default domain of the Container App Environment"
  value       = azurerm_container_app_environment.this.default_domain
}

output "static_ip_address" {
  description = "The static IP address of the Container App Environment"
  value       = azurerm_container_app_environment.this.static_ip_address
}

output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.this.id
}
