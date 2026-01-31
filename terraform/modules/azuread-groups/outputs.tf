output "b2b_users_group_id" {
  description = "The Object ID of the B2B External Users group"
  value       = azuread_group.b2b_users.id
}

output "b2b_users_group_object_id" {
  description = "The Object ID of the B2B External Users group"
  value       = azuread_group.b2b_users.object_id
}
