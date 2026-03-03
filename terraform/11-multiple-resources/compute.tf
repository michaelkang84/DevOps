locals {
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu-east.id,
    nginx  = data.aws_ami.nginx_image.id
  }
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

data "aws_ami" "nginx_image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-nginx-1.28.2-*-debian-12-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

# resource "aws_instance" "from_list" {
#   count         = length(var.ec2_instance_config_list)
#   ami           = local.ami_ids[var.ec2_instance_config_list[count.index].ami]
#   instance_type = var.ec2_instance_config_list[count.index].instance_type
#   subnet_id     = aws_subnet.main[count.index % length(aws_subnet.main)].id

#   tags = {
#     Name    = "${local.project}-instance-${count.index}"
#     Project = local.project
#   }
# }

resource "aws_instance" "from_map" {
  #each.key => holds the key of the map
  #each.value => holds the value of the map
  for_each      = var.ec2_instance_config_map
  ami           = local.ami_ids[each.value.ami]
  instance_type = each.value.instance_type
  subnet_id     = aws_subnet.main[each.value.subnet_index].id

  tags = {
    Name    = "${local.project}-instance-${each.key}"
    Project = local.project
  }
}

# resource "aws_instance" "from_count" {
#   count         = var.ec2_instance_count
#   ami           = data.aws_ami.ubuntu-east.id
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.main[count.index % length(aws_subnet.main)].id
#   # 0 % 4 = 0
#   # 1 % 4 = 1
#   # 2 % 4 = 2
#   # 3 % 4 = 1

#   tags = {
#     Name    = "${local.project}-instance-${count.index}"
#     Project = local.project
#   }
# }