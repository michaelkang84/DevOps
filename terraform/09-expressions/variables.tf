variable "numbers_list" {
  type = list(number)
}

variable "objects_list" {
  type = list(object({
    firstname = string
    lastname  = string
  }))
}

variable "numbers_map" {
  type = map(number)
}

variable "players" {
  type = list(object({
    name    = string
    sponsor = string
  }))
}

variable "player_to_output" {
  type = string
}