resource "aws_s3_bucket" "tf_cloud" {
  bucket = "tf-cloud-${random_id.this.hex}"

  tags = {
    CreatedBy = "Terraform Cloud"
  }
}