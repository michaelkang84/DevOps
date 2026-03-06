resource "random_id" "bucket_suffix" {
  byte_length = 4
}
resource "aws_s3_bucket" "this" {
  count  = var.bucket_count
  bucket = "workspaces-example-${terraform.workspace}-${count.index}-${random_id.bucket_suffix.hex}"
}

# TF_WORKSPACE   env var will be picked up by terraform as the current workspace

# terraform apply -var-file=$(terraform workspace show).tfvars

# alias tf_apply='terraform apply -var-file=$(terraform workspace show).tfvars'