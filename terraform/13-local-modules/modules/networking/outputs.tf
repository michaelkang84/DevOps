# 1. VPC ID
# 2. Public Subnets - subnet_key => { subnet_id, availability_zone }
# 3. Private Subnets - subnet_key => { subnet_id, availability_zone }

locals {
  output_public_subnets = {
    for key in keys(local.public_subnets) : key => {
      subnet_id         = aws_subnet.this[key].id
      availability_zone = aws_subnet.this[key].availability_zone
    }
  }

  output_private_subnets = {
    for key in keys(local.private_subnets) : key => {
      subnet_id         = aws_subnet.this[key].id
      availability_zone = aws_subnet.this[key].availability_zone
    }
  }
}

output "vpc_id" {
  description = "The ID of the VPC created by this module."
  value       = aws_vpc.this.id
}

output "public_subnets" {
  description = "A map of public subnet keys to their IDs and availability zones. The keys correspond to the keys in the subnet_config variable for subnets marked as public."
  value       = local.output_public_subnets
}

output "private_subnets" {
  description = "A map of private subnet keys to their IDs and availability zones. The keys correspond to the keys in the subnet_config variable for subnets marked as private."
  value       = local.output_private_subnets
}