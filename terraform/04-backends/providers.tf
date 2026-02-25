terraform {
  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {

    # Terraform version 1.10.x onwards dynamo table is deprecated
    # use_lockfile = true
    # for state lockingcking
  }


}

provider "aws" {
  region = "us-east-1"
}

