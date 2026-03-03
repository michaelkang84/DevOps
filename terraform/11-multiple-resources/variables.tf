variable "subnet_count" {
  type    = number
  default = 3
}

variable "ec2_instance_count" {
  type    = number
  default = 1
}

variable "subnet_config" {
  type = map(object({
    cidr_block = string
  }))

  # Ensure that all provided CIDR blocks are valid
  validation {
    condition     = alltrue([for subnet in values(var.subnet_config) : can(cidrnetmask(subnet.cidr_block))])
    error_message = "At least one of the provided CIDR blocks is not valid!"
  }
}


variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
    # Optional subnet index with a default value of 0
    # subnet_index  = optional(number, 0)
  }))

  validation {
    condition     = alltrue([for config in values(var.ec2_instance_config_map) : contains(["t2.micro"], config.instance_type)])
    error_message = "Only t2.micro instances are allowed."
  }

  validation {
    condition     = alltrue([for config in values(var.ec2_instance_config_map) : contains(["ubuntu", "nginx"], config.ami)])
    error_message = "Only 'ubuntu' and 'nginx' AMIs are allowed."
  }

  # Could be invalid since terraform might not know how many subnets are going to be created at time of validation
  #   validation {
  #     condition     = alltrue([for config in values(var.ec2_instance_config_map) : config.subnet_index <= length(aws_subnet.main)])
  #     error_message = "Inavlid Subnet index"
  #   }
}

variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
  }))

  default = []

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