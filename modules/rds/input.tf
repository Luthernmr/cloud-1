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
