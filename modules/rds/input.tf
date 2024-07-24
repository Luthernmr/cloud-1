variable "db_user" {
  type    = string
  description = "Username for the master DB users"
}

variable "db_password" {
  type    = string
  description = "Password for the master DB users"
}

variable "env_list" {
  type = list(string)
  description = "List of instance names to create"
}

variable "ft_apps_security_group_id" {
  type = string
  description = "The Ec2 security group id"
}

variable "vpc_id" {
  type = string
  description = "ID of the Virtual Private Cloud containing the EC2"
}

variable "public_subnet_id" {
  type = string
}

variable "public_subnet2_id" {
  type = string
}

