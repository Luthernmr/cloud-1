variable "cloudflare_api_token" {
  type        = string
  description = "Token used to access cloudfare"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "The unique ID to identify the domain/subdomain"
}

variable "env_list" {
  type = list(string)
  default     = ["dev"]
  description = "List of sites to create"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type used to run WordPress"
}

variable "db_user" {
  type = string
  default     = "admin"
  description = "Database user provided to wordpress"
}

variable "db_password" {
  type        = string
  description = "Wordpress database user password"
}

variable "domain_name" {
  type        = string
  default     = "nemorluther.fr"
  description = "Root domain name used to create subdomains"
}

variable "wordpress_subdomain" {
  type        = string
  default     = "wordpress"
  description = "WordPress subdomain prefix appended to domain_name"
}

variable "phpmyadmin_subdomain" {
  type        = string
  default     = "phpmyadmin"
  description = "phpMyAdmin subdomain prefix appended to domain_name"
}
