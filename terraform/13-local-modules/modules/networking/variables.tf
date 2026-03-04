variable "vpc_config" {
  type = object({
    cidr_block = string
    vpc_name   = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The variable vpc_config must be a valid CIDR block."
  }
}