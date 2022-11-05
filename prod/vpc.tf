resource "aws_vpc" "simple_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.simple_vpc.id
  cidr_block        = "10.0.0.0/20"
  availability_zone = "ap-northeast-2a"
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.simple_vpc.id
  cidr_block        = "10.0.16.0/20"
  availability_zone = "ap-northeast-2b"
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id            = aws_vpc.simple_vpc.id
  cidr_block        = "10.0.32.0/20"
  availability_zone = "ap-northeast-2c"
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.simple_vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.simple_vpc.id
}

resource "aws_route_table_association" "public_route_table_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_association_3" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.public_route_table.id
}
