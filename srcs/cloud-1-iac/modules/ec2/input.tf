variable "instance_type" {
  type = string
}

variable "vpc_id" {
  type = string
}
variable "db_endpoint" {}

variable "db_name" {}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "ft_wp_db" {}

variable "env" {
  type = string
}

variable "efs_dns_name" {
  type = string
}

variable "wordpress_subdomain" {
  type = string
}

variable "env_list" {
  type = list(string)
}