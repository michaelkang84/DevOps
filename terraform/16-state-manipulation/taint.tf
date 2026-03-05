resource "aws_s3_bucket" "tainted_bucket" {
  bucket = "tf-state-manipulation-tainted-bucket-2487akljsnfg"
}

resource "aws_s3_bucket_public_access_block" "from_tainted_bucket" {
  bucket = aws_s3_bucket.tainted_bucket.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  lifecycle {
    replace_triggered_by = [
      aws_s3_bucket.tainted_bucket, # Reference the resource you want to trigger a replacement
    ]
  }
}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "this" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.0.0.0/24"
}