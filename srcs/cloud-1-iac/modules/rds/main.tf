resource "aws_db_instance" "ft_wp_db" {
  for_each               = { for env in var.env_list : env => env }
  allocated_storage      = 10
  db_name                = "${each.key}db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = var.db_user
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  skip_final_snapshot    = true
  publicly_accessible    = true
}
