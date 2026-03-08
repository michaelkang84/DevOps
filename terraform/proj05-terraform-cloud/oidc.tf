import {
  to = aws_iam_openid_connect_provider.this
  id = "arn:aws:iam::113817973311:oidc-provider/app.terraform.io"
}

data "tls_certificate" "terraform_cloud" {
  url = "https://${var.terraform_cloud_hostname}"
}

resource "aws_iam_openid_connect_provider" "this" {
  url = data.tls_certificate.terraform_cloud.url

  client_id_list = [
    var.terraform_cloud_audience
  ]

  thumbprint_list = [
    data.tls_certificate.terraform_cloud.certificates[0].sha1_fingerprint
  ]

  tags = {
    CreatedBy = "Terraform Cloud"
    Name      = "Terraform Cloud"
  }
}