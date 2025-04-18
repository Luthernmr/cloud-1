variable "instance_type" {
  type = string
  description = "EC2 instance type (ex: t2.micro)"
}

variable "vpc_id" {
  type = string
  description = "ID of the Virtual Private Cloud containing the EC2"
}

variable "db_endpoint" {
  type = map(string)
  description = "End point for each server instance"
}

variable "db_name" {
  type = map(string)
  description = "Database name for each server instance"
}

variable "db_user" {
  type = string
  description = "Username for the master DB users"
}

variable "db_password" {
  type = string
  description = "Password for the master DB users"
}

variable "domain_name" {
  type = string
  description = "Root domain name"
}

variable "wordpress_subdomain" {
  type = string
  description = "Subdomain prefix used by WordPress"
}

variable "efs_dns_name" {
  type = string
  description = "Domain name of the EFS where WordPress will be installed"
}

variable "env_list" {
  type = list(string)
  description = "List of site instance names to be create"
}

variable "ft_wp_db" {
  type = map(any)
  description = "Wordpress DB used to declore depends_on"
}
