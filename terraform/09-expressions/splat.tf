locals {
  firstnames_from_splat = var.players[*].name
}

output "firstnames_from_splat" {
  value = local.firstnames_from_splat
}