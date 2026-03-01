ec2_volume_config = {
  size = 20
  type = "gp2"
}

ec2_instance_type = "t2.micro"

additional_tags = {
  ValuesFrom = "terraform.tfvars"
}