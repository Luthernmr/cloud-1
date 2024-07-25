variable "domain_name" {
  type = string
  description = "Root domain name used to create subdomains"
}

variable "lt_ids" {
  type = map(string)
  description = "AWS Launch Template ID"
}

variable "lt_version" {
  type = map(string)
  description = "Name of the launch templates version to use"
}

variable "vpc_id" {
  type = string
  description = "AWS Virtual Private Cloud ID"
}

variable "public_subnet_id" {
  type = string
  description = "Subnet containing the EC2 & mount targets"
}

variable "public_subnet2_id" {
  type = string
  # https://docs.aws.amazon.com/elasticloadbalancing/latest/application/application-load-balancers.html#subnets-load-balancer
  description = "Required second unused subnet in another availability zone"
}

variable "wordpress_subdomain" {
  type = string
  description = "WordPress subdomain prefix appended to domain_name"
}

variable "phpmyadmin_subdomain" {
  type = string
  description = "phpMyAdmin subdomain prefix appended to domain_name"
}

variable "env_list" {
  type = list(string)
  description = "List of sites to create"
}

variable "cloudflare_zone_id" {
  type = string
  description = "The unique ID to identify the domain/subdomain"
}
