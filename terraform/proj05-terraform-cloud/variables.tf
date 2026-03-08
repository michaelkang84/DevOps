variable "terraform_cloud_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the Terraform Cloud instance"
  validation {
    condition     = contains(["app.terraform.io", "app.terraform.local"], var.terraform_cloud_hostname)
    error_message = "Invalid Terraform Cloud hostname. Allowed values are: app.terraform.io, app.terraform.local."
  }
}

variable "terraform_cloud_audience" {
  type        = string
  default     = "aws.workload.identity"
  description = "The audience of the Terraform Cloud instance"
  validation {
    condition     = contains(["aws.workload.identity"], var.terraform_cloud_audience)
    error_message = "Invalid Terraform Cloud audience. Allowed values are: aws.workload.identity."
  }
}

variable "admin_role_workspaces" {
  type        = list(string)
  description = "The workspaces to attach the admin role to"
}

variable "admin_role_project" {
  type        = string
  description = "The project to attach the admin role to"
}