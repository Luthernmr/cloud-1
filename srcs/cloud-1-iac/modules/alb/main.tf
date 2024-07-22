resource "aws_lb" "ft_lb" {
  name               = "lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ft_alb_security_group.id]
  subnets = [
    var.public_subnet_id,
    var.public_subnet2_id,
  ]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "ft_wordpress_target_groups" {
  for_each = { for env in var.env_list : "${var.wordpress_subdomain}-${env}" => env }

  name     = each.key
  port     = 9000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
}

resource "aws_lb_target_group" "ft_phpmyadmin_target_groups" {
  for_each = { for env in var.env_list : "${var.phpmyadmin_subdomain}-${env}" => env }

  name     = each.key
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
}

resource "aws_lb_listener" "ft_app_listener" {
  load_balancer_arn = aws_lb.ft_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "ft_app_listener_https" {
  load_balancer_arn = aws_lb.ft_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_iam_server_certificate.ft_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = values(aws_lb_target_group.ft_wordpress_target_groups)[0].arn
  }
}
resource "aws_lb_listener_rule" "ft_wordpress_listener_rules" {
  for_each = { for env in var.env_list : "${var.wordpress_subdomain}-${env}" => env }

  listener_arn = aws_lb_listener.ft_app_listener_https.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ft_wordpress_target_groups[each.key].arn
  }

  condition {
    host_header {
      values = ["${each.key}.${var.domain_name}"]
    }
  }
}

resource "aws_lb_listener_rule" "ft_phpmyadmin_listener_rules" {
  for_each = { for env in var.env_list : "${var.phpmyadmin_subdomain}-${env}" => env }

  listener_arn = aws_lb_listener.ft_app_listener_https.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ft_phpmyadmin_target_groups[each.key].arn
  }

  condition {
    host_header {
      values = ["${each.key}.${var.domain_name}"]
    }
  }
}

resource "aws_autoscaling_group" "ft_wp_asg" {
  for_each            = { for env in var.env_list : env => env }
  name                = each.key
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = [var.public_subnet_id]

  launch_template {
    id      = var.lt_ids[each.key]
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "ft_wordpress_asg_attachment" {
  for_each = { for env in var.env_list : env => env }

  autoscaling_group_name = aws_autoscaling_group.ft_wp_asg[each.key].id
  lb_target_group_arn    = aws_lb_target_group.ft_wordpress_target_groups["wordpress-${each.key}"].arn
}

resource "aws_autoscaling_attachment" "ft_phpmyadmin_asg_attachment" {
  for_each = { for env in var.env_list : env => env }

  autoscaling_group_name = aws_autoscaling_group.ft_wp_asg[each.key].id
  lb_target_group_arn    = aws_lb_target_group.ft_phpmyadmin_target_groups["phpmyadmin-${each.key}"].arn
}


