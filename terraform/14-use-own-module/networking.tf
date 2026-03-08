module "networking-mod" {
  source  = "michaelkang84/networking-mod/aws"
  version = "0.2.0"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    vpc_name   = "13-local-modules"
  }

  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.0.0/24"
      az         = "us-east-1a"
    }

    subnet_2 = {
      cidr_block = "10.0.1.0/24"
      az         = "us-east-1b"
      public     = true
    }
  }
}