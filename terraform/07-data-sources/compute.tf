data "aws_ami" "ubuntu-east" {
    most_recent = true
    owners = ["099720109477"] # Cononical

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}


data "aws_ami" "ubuntu-west" {
    most_recent = true
    owners = ["099720109477"] # Cononical

    provider = aws.us-west

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

output "ubuntu-east" {
  value = data.aws_ami.ubuntu-east.id
}

output "ubuntu-west" {
  value = data.aws_ami.ubuntu-west.id
}


# resource "aws_instance" "web" {
#   ami                         = "ami-015ca9ee3db5edec7" # NGINX AMI Public
#   associate_public_ip_address = true
#   instance_type               = "t3.micro"


#   root_block_device {
#     delete_on_termination = true
#     volume_size           = 10
#     volume_type           = "gp2"
#   }

# }

