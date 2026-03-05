data "aws_vpc" "default" {
  default = true
}

resource "aws_vpc" "custom" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "proj04-custom-vpc"
  }
}

moved {
  from = aws_subnet.allowed
  to   = aws_subnet.private1
}

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.custom.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name   = "subnet-custom-vpc-private1"
    Access = "private"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.custom.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name   = "subnet-custom-vpc-private2"
    Access = "private"
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.custom.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name   = "subnet-custom-vpc-public3"
  }
}

resource "aws_subnet" "not_allowed" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.128.0/24"

  tags = {
    Name = "subnet-default-vpc"
  }
}