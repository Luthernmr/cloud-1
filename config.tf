variable "cloudflare_api_token" {
  type = string
  description = "Token used to access cloudfare"
}

variable "cloudflare_zone_id" {
  type = string
  description = "The unique ID to identify the domain/subdomain"
}

variable "env_list" {
  type = list(string)
  # TODO: rename, simple letters could work well
  default = ["dev", "test", "preprod", "prod"]
  description = "List of sites to create"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
  description = "EC2 instance type used to run WordPress"
}

# TODO: rename
variable "db_user" {
  type    = string
  # TODO: Check if this is a requirement or indeed a default value
  default = "admin"
  description = "Database user provided to wordpress"
}

# TODO: : Use aws secret manager instead
variable "db_password" {
  type    = string
  description = "Wordpress database user password"
}

# TODO: rename (this is the root domain name)
variable "domain_name" {
  type = string
  default = "nemorluther.fr"
  description = "Root domain name used to create subdomains"
}

# TODO: rename (this is a prefix)
variable "wordpress_subdomain" {
  type    = string
  default = "wordpress"
  description = "WordPress subdomain prefix appended to domain_name"
}

# TODO: rename (this is a prefix)
variable "phpmyadmin_subdomain" {
  type    = string
  default = "phpmyadmin"
  description = "phpMyAdmin subdomain prefix appended to domain_name"
}
