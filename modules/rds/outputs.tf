output "ssm_db_password" {
  description = "Name of the SSM parameter for database user password."
  value       = aws_ssm_parameter.db_password.name
}

output "db_ip" {
  description = "Database IP address."
  value       = module.db.this_db_instance_address
}