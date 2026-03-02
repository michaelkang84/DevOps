locals {

  double_numbers = [for n in var.numbers_list : n * 2]
  even_numbers   = [for num in var.numbers_list : num if num % 2 == 0]

  firstnames = [for obj in var.objects_list : obj.firstname]
  fullnames  = [for obj in var.objects_list : "${obj.firstname} ${obj.lastname}"]

}

output "double_numbers" {
  value = local.double_numbers
}

output "even_numbers" {
  value = local.even_numbers
}

output "firstnames" {
  value = local.firstnames
}

output "fullnames" {
  value = local.fullnames
}