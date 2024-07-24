output "alb_dns_name" {
  value = aws_lb.ft_lb.dns_name
  description = "Domain name of the Application Load Balancer"
}
