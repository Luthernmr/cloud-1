resource "aws_security_group" "rds_security_group" {
  name = "rds_sg"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups  = [var.ft_apps_security_group_id]
  }
}
