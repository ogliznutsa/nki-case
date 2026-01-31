variable "name" {
  description = "Name of the Container Registry (alphanumeric only)"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sku" {
  description = "SKU tier (Basic, Standard, Premium)"
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Enable admin user"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
