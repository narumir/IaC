resource "aws_vpc" "k3s_vpc" {
  cidr_block                       = "10.0.0.0/16"
  enable_dns_hostnames             = false
  enable_dns_support               = true
  assign_generated_ipv6_cidr_block = true
  tags = {
    Name = "k3s_vpc"
  }
}

resource "aws_subnet" "k3s_vpc_public_1" {
  vpc_id                          = aws_vpc.k3s_vpc.id
  availability_zone               = "ap-northeast-2a"
  cidr_block                      = cidrsubnet(aws_vpc.k3s_vpc.cidr_block, 4, 0)
  map_public_ip_on_launch         = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.k3s_vpc.ipv6_cidr_block, 8, 0)
  assign_ipv6_address_on_creation = true
}

resource "aws_subnet" "k3s_vpc_public_2" {
  vpc_id                          = aws_vpc.k3s_vpc.id
  availability_zone               = "ap-northeast-2b"
  cidr_block                      = cidrsubnet(aws_vpc.k3s_vpc.cidr_block, 4, 1)
  map_public_ip_on_launch         = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.k3s_vpc.ipv6_cidr_block, 8, 1)
  assign_ipv6_address_on_creation = true
}

resource "aws_subnet" "k3s_vpc_public_3" {
  vpc_id                          = aws_vpc.k3s_vpc.id
  availability_zone               = "ap-northeast-2c"
  cidr_block                      = cidrsubnet(aws_vpc.k3s_vpc.cidr_block, 4, 2)
  map_public_ip_on_launch         = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.k3s_vpc.ipv6_cidr_block, 8, 2)
  assign_ipv6_address_on_creation = true
}

resource "aws_subnet" "k3s_vpc_public_4" {
  vpc_id                          = aws_vpc.k3s_vpc.id
  availability_zone               = "ap-northeast-2d"
  cidr_block                      = cidrsubnet(aws_vpc.k3s_vpc.cidr_block, 4, 3)
  map_public_ip_on_launch         = true
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.k3s_vpc.ipv6_cidr_block, 8, 3)
  assign_ipv6_address_on_creation = true
}

resource "aws_internet_gateway" "k3s_vpc_ig" {
  vpc_id = aws_vpc.k3s_vpc.id
}

resource "aws_default_route_table" "k3s_vpc_route_table" {
  default_route_table_id = aws_vpc.k3s_vpc.default_route_table_id
  route {
    cidr_block = aws_vpc.k3s_vpc.cidr_block
    gateway_id = "local"
  }
  route {
    ipv6_cidr_block = aws_vpc.k3s_vpc.ipv6_cidr_block
    gateway_id      = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k3s_vpc_ig.id
  }
}

resource "aws_route_table_association" "k3s_vpc_public_1_association" {
  subnet_id      = aws_subnet.k3s_vpc_public_1.id
  route_table_id = aws_default_route_table.k3s_vpc_route_table.id
}

resource "aws_route_table_association" "k3s_vpc_public_2_association" {
  subnet_id      = aws_subnet.k3s_vpc_public_2.id
  route_table_id = aws_default_route_table.k3s_vpc_route_table.id
}

resource "aws_route_table_association" "k3s_vpc_public_3_association" {
  subnet_id      = aws_subnet.k3s_vpc_public_3.id
  route_table_id = aws_default_route_table.k3s_vpc_route_table.id
}

resource "aws_route_table_association" "k3s_vpc_public_4_association" {
  subnet_id      = aws_subnet.k3s_vpc_public_4.id
  route_table_id = aws_default_route_table.k3s_vpc_route_table.id
}
