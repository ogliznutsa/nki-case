variable "name" {
  description = "Name of the Container App"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "container_app_environment_id" {
  description = "Container App Environment ID"
  type        = string
}

variable "image" {
  description = "Container image (registry/image:tag)"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "app"
}

variable "cpu" {
  description = "CPU allocation"
  type        = number
  default     = 0.25
}

variable "memory" {
  description = "Memory allocation"
  type        = string
  default     = "0.5Gi"
}

variable "min_replicas" {
  description = "Minimum number of replicas"
  type        = number
  default     = 1
}

variable "max_replicas" {
  description = "Maximum number of replicas"
  type        = number
  default     = 1
}

variable "azure_ad_client_id" {
  description = "Azure AD Client ID"
  type        = string
}

variable "azure_ad_client_secret_kv_id" {
  description = "Key Vault secret ID for Azure AD client secret"
  type        = string
}

variable "azure_ad_tenant_id" {
  description = "Azure AD Tenant ID"
  type        = string
}

variable "nextauth_url" {
  description = "NextAuth URL (FQDN of the app)"
  type        = string
}

variable "nextauth_secret_kv_id" {
  description = "Key Vault secret ID for NextAuth secret"
  type        = string
}

variable "registry_server" {
  description = "Container registry server"
  type        = string
}

variable "user_assigned_identity_ids" {
  description = "List of user-assigned identity IDs"
  type        = list(string)
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
