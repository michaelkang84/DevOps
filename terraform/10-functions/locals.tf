locals {
  name = "Michael Kang"
  age  = 31

  my_object = {
    key1 = 10
    key2 = "my_value"
  }
}

output "example_one" {
  value = startswith(lower(local.name), "mi")
  #   value = upper(local.name)
}

output "example_two" {
  value = pow(local.age, 2)
  # value = abs(-local.age)
}

output "example_three" {
  value = yamldecode(file("${path.module}/users.yaml")).users[*].name
}

output "example_four" {
  value = jsonencode(local.my_object)
  # value = yamlencode(local.my_object)
}