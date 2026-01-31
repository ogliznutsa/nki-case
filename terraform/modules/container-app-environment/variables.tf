variable "name" {
  description = "Name of the Container App Environment"
  type        = string
}

variable "location" {
  description = "Azure region for the Container App Environment"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "log_retention_days" {
  description = "Log retention period in days"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
