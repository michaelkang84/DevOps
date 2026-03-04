locals {
    allowed_instance_types = ["t3.micro", "t2.micro"]
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


  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }

  lifecycle {

    precondition {
      condition = contains(local.allowed_instance_types, var.instance_type)
      error_message = "Invalid instance type. Allowed types are: ${join(", ", local.allowed_instance_types)}."
    }

    postcondition {
      condition     = self.instance_type == "t3.micro"
      error_message = "Only t3.micro instances are allowed."
    }
  }

}