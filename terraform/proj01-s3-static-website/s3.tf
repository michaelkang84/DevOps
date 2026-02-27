resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "static-website" {
  bucket = "mk-terraform-static-website-bucket-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket_public_access_block" "disable-public-access" {
  bucket                  = aws_s3_bucket.static-website.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static-website-public-read" {
  bucket = aws_s3_bucket.static-website.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadForGetBucketObjects"
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.static-website.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "static-website" {
  bucket = aws_s3_bucket.static-website.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}