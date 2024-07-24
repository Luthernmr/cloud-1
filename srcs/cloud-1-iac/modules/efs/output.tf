output "efs_dns_name" {
  value = aws_efs_file_system.ft_wp_efs.dns_name
  description = "EFS domain name to refer to it in subnet"
}
