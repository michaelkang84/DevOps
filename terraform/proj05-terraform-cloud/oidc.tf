import {
  to = aws_iam_openid_connect_provider.this
  id = "arn:aws:iam::113817973311:oidc-provider/app.terraform.io"
}

import {
  to = aws_iam_role.terraform_cloud_admin
  id = "terraform-cloud-automation-admin"
}

import {
  to = aws_iam_role_policy_attachment.terraform_cloud_admin
  id = "${aws_iam_role.terraform_cloud_admin.name}/${data.aws_iam_policy.admin_policy.arn}"
}

data "tls_certificate" "terraform_cloud" {
  url = "https://${var.terraform_cloud_hostname}"
}

resource "aws_iam_openid_connect_provider" "this" {
  url = data.tls_certificate.terraform_cloud.url

  client_id_list = [
    var.terraform_cloud_audience
  ]

  thumbprint_list = [data.tls_certificate.terraform_cloud.certificates[0].sha1_fingerprint]
  #   thumbprint_list = data.tls_certificate.terraform_cloud.certificates.*.sha1_fingerprint

  tags = {
    CreatedBy = "Terraform Cloud"
    Name      = "Terraform Cloud"
  }
}

data "aws_iam_policy_document" "terraform_cloud_admin_assume_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.this.arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "${var.terraform_cloud_hostname}:aud"
      values   = [var.terraform_cloud_audience]
    }
    condition {
      test     = "StringLike"
      variable = "${var.terraform_cloud_hostname}:sub"
      values   = [for workspace in var.admin_role_workspaces : "organization:MichaelKang:project:${var.admin_role_project}:workspace:${workspace}:run_phase:*"]
    }
  }
}

resource "aws_iam_role" "terraform_cloud_admin" {
  name               = "terraform-cloud-automation-admin"
  assume_role_policy = data.aws_iam_policy_document.terraform_cloud_admin_assume_policy.json
}

data "aws_iam_policy" "admin_policy" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "terraform_cloud_admin" {
  role       = aws_iam_role.terraform_cloud_admin.name
  policy_arn = data.aws_iam_policy.admin_policy.arn
}