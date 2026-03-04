locals {
  public_subnets = {
    for key, subnet in var.subnet_config : key => subnet if subnet.public
    # for key, subnet in var.subnet_config : key => subnet
    # if lookup(subnet, "public", false) == true
  }

  private_subnets = {
    for key, subnet in var.subnet_config : key => subnet if !subnet.public
  }
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_config.cidr_block

  tags = {
    Name = var.vpc_config.vpc_name
  }

}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "this" {
  for_each = var.subnet_config

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = "${var.vpc_config.vpc_name}-${each.key}"
    Access = each.value.public ? "public" : "private"
  }

  lifecycle {
    precondition {
      condition     = contains(data.aws_availability_zones.available.names, each.value.az)
      error_message = "Invalid availability zone: ${each.value.az}. Must be one of: ${join(", ", data.aws_availability_zones.available.names)}"
    }
  }
}

resource "aws_internet_gateway" "this" {
  # just deploy one even if there are more than one public subnets
  count = length(keys(local.public_subnets)) > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_config.vpc_name}-igw"
  }

}

resource "aws_route_table" "public_rtb" {
  count = length(keys(local.public_subnets)) > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this[0].id
  }
}

resource "aws_route_table_association" "public" {
  for_each = local.public_subnets

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.public_rtb[0].id
}