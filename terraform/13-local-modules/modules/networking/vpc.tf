resource "aws_vpc" "this" {
  cidr_block = var.vpc_config.cidr_block

  tags = {
    Name = var.vpc_config.vpc_name
  }

}

resource "aws_subnet" "this" {
  for_each = var.subnet_config

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = "${var.vpc_config.vpc_name}-${each.key}"
  }
}