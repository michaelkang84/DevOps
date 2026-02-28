# variable "aws_region" {
#     type = string
#     description = "The AWS region to deploy the resources to"
#     default = "us-east-1"
# }

variable "ec2_instance_size" {
  type        = string
  description = "Size of Managed EC2 instance"
  default     = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t2.micro"], var.ec2_instance_size)
    error_message = "Invalid EC2 instance size. Allowed values are: t3.micro, t2.micro."
  }

}

# variable "ec2_volume_size" {
#   type        = number
#   description = "Size of the root block device volume in GB of Managed ec2 instances"

# }

# variable "ec2_volume_type" {
#   type        = string
#   description = "Volume type betweewn GP2 and GP3 of the root block device volume of Managed EC2 instances"

# }

# map is better for arbitrary values

# variable "ec2_volume_config" {

#   type = map(object({
#     size = number
#     type = string
#   }))

#   description = "Size of the root block device volume in GB of Managed ec2 instances"

#   default = {
#     config = {
#       size = 10
#       type = "gp3"
#     }
#   }

# }

variable "ec2_volume_config" {

  type = object({
    size = number
    type = string
  })

  description = "Size of the root block device volume in GB of Managed ec2 instances"

  default = {
    size = 10
    type = "gp3"
  }

}

variable "additional_tags" {
  type = map(string)

  default = {}

  # default = {
  #     "Environment" = "dev"
  #     "Owner" = "John Doe"
  # }
}