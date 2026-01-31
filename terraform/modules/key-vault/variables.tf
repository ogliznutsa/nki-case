variable "name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region for the Key Vault"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "sku_name" {
  description = "SKU name for Key Vault (standard or premium)"
  type        = string
  default     = "standard"
}

variable "soft_delete_retention_days" {
  description = "Number of days to retain soft-deleted keys"
  type        = number
  default     = 90
}

variable "purge_protection_enabled" {
  description = "Enable purge protection (recommended for production)"
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Enable for disk encryption"
  type        = bool
  default     = false
}

variable "access_policies" {
  description = "List of access policies to create"
  type = list(object({
    object_id               = string
    secret_permissions      = optional(list(string), [])
    key_permissions         = optional(list(string), [])
    certificate_permissions = optional(list(string), [])
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to the Key Vault"
  type        = map(string)
  default     = {}
}
