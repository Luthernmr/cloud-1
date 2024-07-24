terraform {
  required_version = "~> 1.9.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_db_instance" "ft_wp_db" {
  for_each               = { for env in var.env_list : env => env }
  allocated_storage      = 10 # Available storage in GigaBytes
  db_name                = "${each.key}db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro" # T3 Micro for RDS instances
  username               = var.db_user
  password               = var.db_password
  # Use the default paramaters for MySQL on RDS
  parameter_group_name   = "default.mysql8.0"
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  # Create a snapshot before deleting the database
  skip_final_snapshot    = true
  # TODO: Document
  publicly_accessible    = true
}
