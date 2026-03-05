# CLI Command:
# terraform import aws_s3_bucket.remote_state 'mk-terraform-state-bucket-555'
resource "aws_s3_bucket" "remote_state" {
  bucket = "mk-terraform-state-bucket-555"

  tags = {
    ManagedBy = "Terraform"
    lifecycle = "Critical"
  }

  lifecycle {
    prevent_destroy = true
  }
}

import {
  to = aws_s3_bucket_public_access_block.remote_state
  id = aws_s3_bucket.remote_state.bucket
}

resource "aws_s3_bucket_public_access_block" "remote_state" {
  bucket = aws_s3_bucket.remote_state.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}