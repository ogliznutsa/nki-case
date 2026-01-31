variable "environment" {
  description = "Environment name (dev, prod)"
  type        = string
}

variable "redirect_uris" {
  description = "List of redirect URIs for the application"
  type        = list(string)
}
