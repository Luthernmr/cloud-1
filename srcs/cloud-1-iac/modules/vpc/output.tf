output "vpc_id" {
  value = aws_vpc.ft_wp_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "public_subnet2_id" {
  value = aws_subnet.public_subnet2.id
}