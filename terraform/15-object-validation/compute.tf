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
  instance_type = var.instance_type
  subnet_id = aws_subnet.this.id


  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }

  lifecycle {

    create_before_destroy = true

    precondition {
      condition     = contains(local.allowed_instance_types, var.instance_type)
      error_message = "Var Invalid instance type. Allowed types are: ${join(", ", local.allowed_instance_types)}."
    }

    postcondition {
      condition     = contains(local.allowed_instance_types, self.instance_type)
      error_message = "Self Invalid instance type. Allowed types are: ${join(", ", local.allowed_instance_types)}."
    }

  }

}