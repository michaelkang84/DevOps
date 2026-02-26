resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name      = "06-resources"
    ManagedBy = "Terraform"
    Project   = "06-resources"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name      = "06-resources-public"
    ManagedBy = "Terraform"
    Project   = "06-resources"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name      = "06-resources-main-igw"
    ManagedBy = "Terraform"
    Project   = "06-resources"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name      = "06-resources-public-rtb"
    ManagedBy = "Terraform"
    Project   = "06-resources"
  }
}  

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}