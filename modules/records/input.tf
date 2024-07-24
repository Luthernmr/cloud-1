variable "cloudflare_zone_id" {
  type = string
  description = "The unique ID to identify the domain/subdomain"
}

variable "alb_dns_name" {
  type = string
  description = "Entry to point to the server"
}

variable "wordpress_subdomain" {
  type = string
  description = "Subdomain prefix for WordPress"
}

variable "phpmyadmin_subdomain" {
  type = string
  description = "Subdomain prefix for phpMyAdmin"
}

variable "env_list" {
  type = list(string)
  description = "Server instance names used to suffix subdomains"
}

