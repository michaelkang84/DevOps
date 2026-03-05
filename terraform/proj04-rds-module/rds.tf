module "database" {
  source = "./modules/RDS"

  project_name = "proj04-rds-module"
  storage_size = 10

  credentials = {
    username = "db-admin"
    password = "Admin1234"
  }

  subnet_ids = []

  security_group_ids = []
}