terraform {
  cloud {

    organization = "MichaelKang"

    workspaces {
      name = "terraform-cli2"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}