variable "domain_name" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}

variable "alb_dns_name" {
  type = string
}

variable "wordpress_subdomain" {
  type = string
}

variable "phpmyadmin_subdomain" {
  type = string
}

variable "env_list" {
  type = list(string)
}