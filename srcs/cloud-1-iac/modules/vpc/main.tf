resource "aws_vpc" "ft_wp_vpc" {
  cidr_block = "10.0.0.0/16"
  
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.ft_wp_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-3a"
  map_public_ip_on_launch = true  
}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.ft_wp_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-3b"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.ft_wp_vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ft_wp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public.id
}