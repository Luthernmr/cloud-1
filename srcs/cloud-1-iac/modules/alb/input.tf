variable "domain_name" {
  type = string
}
variable "lt_ids" {

}

variable "vpc_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "public_subnet2_id" {
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
