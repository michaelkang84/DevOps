# ====================
# Subnet Validation
# ====================

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "input" {
  for_each = toset(var.subnet_ids)
  id       = each.value

  lifecycle {
    postcondition {
      condition     = self.vpc_id != data.aws_vpc.default.id
      error_message = <<-EOT
        The following subnet is part of the default VPC:

        Name: ${self.tags.Name}
        ID: ${self.id}

        Please do deploy RDS Instances in the default VPC.
        EOT
    }

    postcondition {
      condition     = can(lower(self.tags.Access) == "private")
      error_message = "The following subnet does not have the required tag 'Access' with value 'private':"
    }
  }
}


# ====================
# Security Group Validation
# ====================

data "aws_vpc_security_group_rules" "input" {
  filter {
    name   = "group-id"
    values = var.security_group_ids
  }
}

data "aws_vpc_security_group_rule" "input" {
  for_each               = toset(data.aws_vpc_security_group_rules.input.ids)
  security_group_rule_id = each.value

  lifecycle {
    postcondition {
      condition = (self.is_egress ? true :
        self.cidr_ipv4 == null &&
        self.cidr_ipv6 == null &&
        self.referenced_security_group_id != null
      )
      error_message = <<-EOT
        The following security group contains an invvalid inbound rule:

        Security Group ID: ${self.security_group_id}
      EOT
    }

  }
}