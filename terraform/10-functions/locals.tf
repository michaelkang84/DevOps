locals {
  name = "Michael Kang"
  age  = 31
}

output "example_one" {
  value = startswith(lower(local.name), "mi")
#   value = upper(local.name)
}

output "example_two" {
    value = pow(local.age, 2)
    # value = abs(-local.age)
}