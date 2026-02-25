terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}

#actively managed by us
resource "aws_s3_bucket" "my_bucket" {
    bucket = var.bucket_name
}

# Managed somewhere else, we just want to use in our project
data "aws_s3_bucket" "my_bucket" {
    bucket = "not_managed_by_us"
}

variable "bucket_name" {
    type = string
    description = "The name of the bucket"
    default = "my-custom-bucket"
}

output "bucket_id" {
    value = aws_s3_bucket.my_bucket.id
    # value = local.local_example
}

# temp variables
locals {
    local_example = "this is local variable"
}

module "my_module" {
    source = "./module_example"
    module_variable = "this is module variable"
}