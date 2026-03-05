/*
1. terraform state mv ARGS...


*/

locals {
  ec2_names = ["instance_1", "instance_2"]
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

moved {
  from = aws_instance.this_new["instance_1"]
  to   = aws_instance.new_final
}
moved {
  from = aws_instance.this_new["instance_2"]
  to   = module.compute.aws_instance.this
}

resource "aws_instance" "new_final" {
  ami           = data.aws_ami.ubuntu-east.id
  instance_type = "t3.micro"
}

module "compute" {
    source = "./modules/compute"
    ami_id = data.aws_ami.ubuntu-east.id
}