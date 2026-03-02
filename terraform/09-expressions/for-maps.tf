locals {
  standings_map = { for k, v in var.numbers_map : k => "${v}: ${k}" }
}

output "standings" {
  value = local.standings_map
}