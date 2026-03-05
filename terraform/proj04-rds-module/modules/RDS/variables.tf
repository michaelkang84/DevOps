####################
# General Information
####################
variable "project_name" {
  description = "value used for naming and tagging resources"
  type        = string
}

####################
# DB Configuration
####################

variable "instance_class" {
  description = "value used to specify the instance class for the RDS instance. Allowed values are: db.t3.micro, db.t4g.micro due to free tier access."
  type        = string
  default     = "db.t3.micro"

  validation {
    condition = contains(["db.t3.micro", "db.t4g.micro"], var.instance_class)

    error_message = "Invalid instance class. Allowed values are: db.t3.micro, db.t4g.micro due to free tier access."
  }
}

variable "storage_size" {
  description = "value used to specify the allocated storage size for the RDS instance in GB. Must be between 5 and 10 GB to stay within free tier limits."
  type        = number
  default     = 10

  validation {
    condition     = var.storage_size > 5 && var.storage_size <= 10
    error_message = "value must be between 5 and 10 GB to stay within free tier limits."
  }
}

variable "engine" {
  description = "value used to specify the database engine for the RDS instance. Allowed values are: postgress-latest, postgres-14 due to free tier access."
  type        = string
  default     = "postgres-latest"

  validation {
    condition = contains(["postgres-latest", "postgres-14"], var.engine)

    error_message = "Invalid engine. Allowed values are: postgress-latest, postgres-14 due to free tier access."
  }

}

####################
# DB Credentials
####################

variable "credentials" {
  description = "value used to specify the credentials for the RDS instance. The password must contain at least 1 character, at least 1 number, and be at least 8 digits long."
  type = object({
    username = string
    password = string
  })

  sensitive = true

  validation {
    condition = alltrue([
      length(regexall("[0-9]", var.credentials.password)) > 0,
      length(regexall("[a-zA-Z]", var.credentials.password)) > 0,
      length(regexall("^[a-zA-Z0-9]{8,}$", var.credentials.password)) > 0
    ])
    error_message = <<-EOT
    Password must comply with the following format:
    1. Contain at least 1 character
    2. Contain at least 1 number
    3 Be at least 8 digits long
    EOT
  }

}

####################
# DB Network
####################

variable "subnet_ids" {
  description = "value used to specify the subnet IDs for the RDS instance. Must be a list of valid subnet IDs."
  type        = list(string)
}

variable "security_group_ids" {
  description = "value used to specify the security group IDs for the RDS instance. Must be a list of valid security group IDs."
  type        = list(string)
}