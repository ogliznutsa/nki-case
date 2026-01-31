variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod)"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable "key_vault_purge_protection" {
  description = "Enable purge protection for Key Vault"
  type        = bool
  default     = false
}

variable "log_retention_days" {
  description = "Log retention period in days"
  type        = number
  default     = 30
}

variable "app_image_tag" {
  description = "Container image tag for the app"
  type        = string
  default     = "dev-latest"
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}
