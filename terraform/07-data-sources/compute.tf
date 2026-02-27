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

output "ubuntu-east" {
  value = data.aws_ami.ubuntu-east.id
}


