output "rds_endpoint" {
  value = module.database.aws_instance_endpoint
}