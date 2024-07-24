variable "public_subnet_id" {
  type = string
  description = "Subnet where the EFS mount target is created"
}

variable "vpc_id" {
  type = string
  description = "Virtual private cloud ID containing the EFS"
}

variable "ft_apps_security_group_id" {
  type = string
  description = "Security Group Authorized to access the EFS"
}
