locals {
  firstnames_from_splat = toset(var.players[*].name)

  sponsors_from_splat = values(local.players_map_two)[*].sponsors
}

output "firstnames_from_splat" {
  value = local.firstnames_from_splat
}

output "sponsors_from_splat" {
  value = local.sponsors_from_splat
}