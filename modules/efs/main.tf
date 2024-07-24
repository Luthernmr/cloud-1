terraform {
  required_version = "~> 1.9.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_efs_file_system" "ft_wp_efs" {
  creation_token = "ft_efs_token"

  tags = {
    Name = "ft_wp_efs"
  }
}

resource "aws_efs_mount_target" "mount_targets" {
  file_system_id  = aws_efs_file_system.ft_wp_efs.id
  subnet_id       = var.public_subnet_id
  security_groups = [aws_security_group.efs_sg.id]
}
