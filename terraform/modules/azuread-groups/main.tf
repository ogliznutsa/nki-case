resource "azuread_group" "b2b_users" {
  display_name     = "B2B-External-Users-${var.environment}"
  security_enabled = true
  description      = "B2B external users for ${var.environment} environment"
}
