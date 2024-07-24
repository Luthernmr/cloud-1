variable "instance_type" {
  type = string
  description = "EC2 instance type (ex: t2.micro)"
}

variable "vpc_id" {
  type = string
  description = "ID of the Virtual Private Cloud containing the EC2"
}

# TODO: rename
variable "db_endpoint" {
  type = map(string)
  description = "End point for each server instance"
}

# TODO: rename
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

# Required to order setup order see `depends_on`
variable "ft_wp_db" {
  # TODO: find type
  type = map(any)
  description = "aws_db_instance ressource on which it depends"
}

variable "env" {
  type = string
  description = "directory that contains in environment/ that contains the .env template used by docker compose"
}

variable "efs_dns_name" {
  type = string
  description = "Domain name of the EFS where WordPress will be installed"
}

variable "env_list" {
  type = list(string)
  description = "List of site instance names to be create"
}
