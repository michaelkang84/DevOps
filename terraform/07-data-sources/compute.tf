# data "aws_ami" "ubuntu-west" {
#     most_recent = true
#     owners = ["099720109477"] # Cononical

#     provider = aws.us-west

#     filter {
#         name   = "name"
#         values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
#     }

#     filter {
#         name = "virtualization-type"
#         values = ["hvm"]
#     }
# }


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

# data "aws_ssm_parameter" "ubuntu_ami" {
#   name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
# }

resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu-east.id
  associate_public_ip_address = true
  instance_type               = "t3.micro"


  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }

}

data "aws_caller_identity" "current" {}

# data "aws_region" "current" {}

data "aws_region" "current" {
  provider = aws.us-west
}

data "aws_vpc" "prod_vpc" {
  tags = {
    Env = "Prod"
  }
}

output "prod_vpc" {
  value = data.aws_vpc.prod_vpc.id
}


output "caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "region" {
  value = data.aws_region.current.name
}

output "ubuntu-east" {
  value = data.aws_ami.ubuntu-east.id
}


