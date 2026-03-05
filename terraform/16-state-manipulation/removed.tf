# CLI Command: 
# terraform state rm -dry-run aws_s3_bucket.my_bucket
removed {
  from = aws_s3_bucket.my_bucket_new

  lifecycle {
    destroy = false
  }
}

# resource "aws_s3_bucket" "my_bucket_new" {
#   bucket = "my-random-bucket-name-asdjhflaksjhfburngej48"
# }