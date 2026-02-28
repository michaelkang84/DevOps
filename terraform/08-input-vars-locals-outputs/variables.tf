# variable "aws_region" {
#     type = string
#     description = "The AWS region to deploy the resources to"
#     default = "us-east-1"
# }

variable "ec2_instance_size" {
  type        = string
  description = "Size of Managed EC2 instance"
  default = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t2.micro"], var.ec2_instance_size)
    error_message = "Invalid EC2 instance size. Allowed values are: t3.micro, t2.micro."
  }

}

variable "ec2_volume_size" {
  type        = number
  description = "Size of the root block device volume in GB of Managed ec2 instances"

}

variable "ec2_volume_type" {
  type        = string
  description = "Volume type betweewn GP2 and GP3 of the root block device volume of Managed EC2 instances"

}