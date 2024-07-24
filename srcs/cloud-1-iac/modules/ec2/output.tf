output "lt_ids" {
  value = { for key, lt in aws_launch_template.ft_wp_lt : key => lt.id }
  description = "Launch template ID for each server instance name"
}

output "ft_apps_security_group_id" {
  value = aws_security_group.ft_apps_security_group.id
  description = "EC2 security group ID"
}
