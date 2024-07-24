output "rds_endpoints" {
  value = { for key, rds_instance in aws_db_instance.ft_wp_db : key => rds_instance.endpoint }
  description = "End point for each server instance name"
}

output "db_instance_name" {
  value = { for key, rds_instance in aws_db_instance.ft_wp_db : key => rds_instance.db_name}
}

output "ft_wp_db" {
  value = aws_db_instance.ft_wp_db
}
