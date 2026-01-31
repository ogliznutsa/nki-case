output "id" {
  description = "The ID of the Container App"
  value       = azurerm_container_app.this.id
}

output "fqdn" {
  description = "The FQDN of the Container App"
  value       = azurerm_container_app.this.ingress[0].fqdn
}

output "latest_revision_name" {
  description = "The name of the latest revision"
  value       = azurerm_container_app.this.latest_revision_name
}


output "outbound_ip_addresses" {
  description = "Outbound IP addresses of the Container App"
  value       = azurerm_container_app.this.outbound_ip_addresses
}
