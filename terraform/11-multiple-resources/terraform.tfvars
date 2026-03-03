# subnet_count = 2

ec2_instance_count = 0


# !! Simply updating list order will cause resource destruction
ec2_instance_config_list = [
  {
    instance_type = "t2.micro"
    ami           = "ubuntu"
  },
  {
    instance_type = "t2.micro"
    ami           = "nginx"
  }
]

ec2_instance_config_map = {
  ubuntu_1 = {
    instance_type = "t2.micro"
    ami           = "ubuntu"
  }

  nginx_1 = {
    instance_type = "t2.micro"
    ami           = "nginx"
    subnet_index  = 1
  }
}