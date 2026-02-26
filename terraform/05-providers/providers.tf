terraform {
  required_version = "~> 1.0"

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

provider "aws" {
  region = "us-west-1"
  alias  = "us-west"
}

resource "aws_s3_bucket" "us-east-1-bucket" {
  bucket = "my-custom-bucket-qwerqwebbs"

}

resource "aws_s3_bucket" "us-west-1-bucket" {
  bucket   = "my-custom-bucket-asdfasdfasfsdf"
  provider = aws.us-west
}
