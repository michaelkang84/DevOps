resource "aws_s3_bucket" "this" {
  bucket = "tf-cloud-bucket-8gfj3krfh"

  tags = {
    CreatedBy = "Terraform Cloud"
    Name      = "Terraform Cloud Bucket"
  }
}