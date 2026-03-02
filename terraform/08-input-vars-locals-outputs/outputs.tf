output "s3_bucket_name" {
  value     = aws_s3_bucket.project_bucket.bucket
  sensitive = true
}

output "my_senesitive_var_output" {
  value     = var.my_sensitive_var
  sensitive = true
}