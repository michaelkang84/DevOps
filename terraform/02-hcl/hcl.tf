terraform {

  # The backend block is used to configure where and how Terraform stores its state file.
  # It defines the backend type (e.g., local, s3, remote) and any relevant settings for storing
  # and locking the Terraform state, ensuring state consistency and allowing for collaboration.

  # The required_version block within the terraform block specifies which versions of Terraform
  # are compatible with this configuration. It allows you to enforce a minimum Terraform version,
  # a maximum version, or a version range. This helps ensure consistency across different environments,
  # avoids breaking changes from future Terraform releases, and facilitates collaboration by making
  # sure everyone working with the code uses a known-working Terraform version.
  #
  # Example:
  # required_version = ">= 1.3.0, < 2.0.0"
  # Examples of specifying required_version constraints:
  #
  # Minimum version only (any version 1.3.0 or higher):
  # required_version = ">= 1.3.0"
  #
  # Specific version only (exactly 1.3.0):
  # required_version = "= 1.3.0"
  #
  # Range (any version greater than or equal to 1.3.0 and less than 2.0.0):
  # required_version = ">= 1.3.0, < 2.0.0"
  #
  # Exclude a specific version (any 1.x except 1.4.0):
  # required_version = "~> 1.3, != 1.4.0"
  #
  # Allow patch-level updates (1.3.x, but not 1.4.x or higher):
  # required_version = "~> 1.3.0"




  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}
# can't use variables in this block

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