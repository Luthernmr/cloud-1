terraform {
  required_version = "~> 1.9.2"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

resource "cloudflare_record" "wordpress_records" {
  for_each = { for env in var.env_list  : env => env }

  name    = "${var.wordpress_subdomain}-${each.key}"
  zone_id = var.cloudflare_zone_id
  value   = var.alb_dns_name
  type    = "CNAME"
  ttl     = 300
}

resource "cloudflare_record" "phpmyadmin_records" {
  for_each = { for env in var.env_list  : env => env }
  
  name    = "${var.phpmyadmin_subdomain}-${each.key}"
  zone_id = var.cloudflare_zone_id
  value   = var.alb_dns_name 
  type    = "CNAME"
  ttl     = 300
}

