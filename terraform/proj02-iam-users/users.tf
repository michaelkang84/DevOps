/*
{
    username: string
    roles: string[]
}[]

{
    username => roles[]
}
*/
locals {
  users_from_yaml = yamldecode(file("${path.module}/user-roles.yaml")).users
  users_map = {
    for user in local.users_from_yaml : user.username => user.roles
  }

  # This will now throw an error if there are duplicate keys which is a safter design

  #   users_map = {
  #     for user in local.users_from_yaml : user.username => user.roles...
  #   }
  #   flattened_user_maps = {
  #     for user, roles in local.users_map : user => flatten(roles)
  #   }
}

resource "aws_iam_user" "users" {
  for_each = toset(local.users_from_yaml[*].username)
  name     = each.value
}

resource "aws_iam_user_login_profile" "user_login_profiles" {
  for_each        = aws_iam_user.users
  user            = each.value.name
  password_length = 8

  lifecycle {
    ignore_changes = [password_length, password_reset_required, pgp_key]
  }
}

output "users_map" {
  value = local.users_map
}

# output "passwords" {
#   sensitive = true
#   value = {
#     for user in aws_iam_user.users : user.name => aws_iam_user_login_profile.user_login_profiles[user.name].password
#   }
# }