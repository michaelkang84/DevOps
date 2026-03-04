locals {
  project = "13-local-modules"
}

data "aws_ami" "ubuntu-east" {
  most_recent = true
  owners      = ["099720109477"] # Cononical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu-east.id
  instance_type = "t3.micro"
  subnet_id     = module.vpc.private_subnets["subnet_1"].subnet_id

  tags = {
    Name    = local.project
    Project = local.project
  }
}