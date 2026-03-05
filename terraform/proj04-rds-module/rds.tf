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
    aws_subnet.private2.id
  ]

  security_group_ids = [
    aws_security_group.compliant.id
  ]
}