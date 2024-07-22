resource "aws_security_group" "efs_sg" {
  name        = "allow_from_public_instances"
  description = "Allow traffice from public instance sg only"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [var.ft_apps_security_group_id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [var.ft_apps_security_group_id]
  }

  tags = {
    "Name" = "efs_sg"
  }
}
