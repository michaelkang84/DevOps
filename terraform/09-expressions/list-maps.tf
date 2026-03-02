# locals {
#     player_with_sponsor = {
#         for player in var.players : player.name => {
#             sponsor = player.sponsor
#         }
#     }
# }
locals {
  player_with_sponsor = { for player in var.players : player.name => player.sponsor... }

  players_map_two = {
    for name, sponsors in local.player_with_sponsor : name => {
        sponsors = sponsors
    }
  }
}

output "players_with_sponsor" {
  value = local.player_with_sponsor

}

output "players_map_two" {
  value = local.players_map_two
}

output "michaels_sponsor" {
  value = local.player_with_sponsor["Michael"]
}