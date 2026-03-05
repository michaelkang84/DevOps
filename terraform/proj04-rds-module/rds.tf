module "database" {
  source = "./modules/RDS"

  project_name = "proj04-rds-module"
  storage_size = 10

  credentials = {
    username = "db-admin"
    password = "Admin1234"
  }

  subnet_ids = [
    aws_subnet.private1.id,
    aws_subnet.public1.id
  ]

  security_group_ids = []
}