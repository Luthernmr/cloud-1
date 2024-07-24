resource "aws_db_instance" "ft_wp_db" {
  for_each               = { for env in var.env_list : env => env }
  # TODO: Document
  allocated_storage      = 10
  db_name                = "${each.key}db"
  engine                 = "mysql"
  engine_version         = "8.0"
  # TODO: Document
  instance_class         = "db.t3.micro"
  username               = var.db_user
  password               = var.db_password
  # TODO: Document
  parameter_group_name   = "default.mysql8.0"
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  # TODO: Document
  skip_final_snapshot    = true
  # TODO: Document
  publicly_accessible    = true
}
