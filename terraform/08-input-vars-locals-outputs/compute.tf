locals {
  project       = "08-input-vars-locals-outputs"
  project_owner = "terraform-course"
  cost_center   = "1234"
  managed_by    = "Terraform"
}

locals {
  common_tags = {
    project     = local.project
    owner       = local.project_owner
    cost_center = local.cost_center
    managed_by  = local.managed_by
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

resource "aws_instance" "web-compute" {

  ami           = data.aws_ami.ubuntu-east.id
  instance_type = var.ec2_instance_type

  tags = merge(
    local.common_tags,
    var.additional_tags
  )

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_volume_config.size
    volume_type           = var.ec2_volume_config.type
  }

}