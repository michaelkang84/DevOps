variable "ec2_instance_type" {
  type = string
  validation {
    condition     = var.ec2_instance_type == "t3.micro"
    error_message = "value must be t3.micro"
  }
}