output "vpc_id" {
  value = aws_vpc.ft_wp_vpc.id
  description = "ID of the Virtual Private Cloud"
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
  description = "Subnet containing EC2 instance"
}

# TODO
output "public_subnet2_id" {
  value = aws_subnet.public_subnet2.id
  description = "Unused subnet in another AZ required by ALB"
}
