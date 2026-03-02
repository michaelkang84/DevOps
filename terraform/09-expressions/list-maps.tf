locals {
  player_with_sponsor = { for player in var.players : player.name => player.sponsor... }

  players_map_two = {
    for name, sponsors in local.player_with_sponsor : name => {
      sponsors = sponsors
    }
  }

  players_from_map = [
    for name, sponsors in local.player_with_sponsor : name
  ]
}

output "players_with_sponsor" {
  value = local.player_with_sponsor

}

output "players_map_two" {
  value = local.players_map_two
}

output "player_sponsors" {
  value = local.players_map_two[var.player_to_output].sponsors
}

output "players_from_map" {
  value = local.players_from_map
}