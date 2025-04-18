terraform {
  required_version = "~> 1.9.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3"
    }
  }
}

resource "aws_launch_template" "ft_wp_lt" {
  for_each      = { for env in var.env_list : env => env }
  name_prefix   = "${each.key}-instance-wp-phpma"
  image_id      = "ami-0320905eab6995d03"
  instance_type = var.instance_type

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  network_interfaces {
    security_groups             = [aws_security_group.ft_apps_security_group.id]
    associate_public_ip_address = true
    delete_on_termination       = true
  }
  
  depends_on = [ var.ft_wp_db ]
  user_data = base64encode(data.cloudinit_config.ft_wp_init_config[each.key].rendered)

  tags = {
    Name = "${each.key}-instance"
  }
}
