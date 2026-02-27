output "website_url" {
  value = aws_s3_bucket_website_configuration.static-website-website-configuration.website_endpoint
}

# terraform output website_url