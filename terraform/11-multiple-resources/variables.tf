variable "subnet_count" {
  type    = number
  default = 3
}

variable "ec2_instance_count" {
  type    = number
  default = 1
}

variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
  }))

  # Ensure that only t2.micro instances are allowed
  # 1. Map from the object to the instance_type
  # 2. Map from the instance_type to a boolean indicating whether it's valid or not
  # 3. Check whether list of booleans contain only true values

  # Ensure that only t2.micro instances are allowed
  validation {
    condition     = alltrue([for config in var.ec2_instance_config_list : contains(["t2.micro"], config.instance_type)])
    error_message = "Only t2.micro instances are allowed."
  }

  validation {
    condition     = alltrue([for config in var.ec2_instance_config_list : contains(["ubuntu", "nginx"], config.ami)])
    error_message = "Only 'ubuntu' and 'nginx' AMIs are allowed."
  }
}