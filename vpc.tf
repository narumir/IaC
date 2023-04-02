resource "aws_vpc" "seoul_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "seoul_public_subnet_1" {
  vpc_id            = aws_vpc.seoul_vpc.id
  cidr_block        = "10.0.0.0/20"
  availability_zone = "ap-northeast-2a"
}

resource "aws_subnet" "seoul_public_subnet_2" {
  vpc_id            = aws_vpc.seoul_vpc.id
  cidr_block        = "10.0.16.0/20"
  availability_zone = "ap-northeast-2b"
}

resource "aws_subnet" "seoul_public_subnet_3" {
  vpc_id            = aws_vpc.seoul_vpc.id
  cidr_block        = "10.0.32.0/20"
  availability_zone = "ap-northeast-2c"
}

resource "aws_internet_gateway" "seoul_igw" {
  vpc_id = aws_vpc.seoul_vpc.id
}

resource "aws_route_table" "seoul_public_table" {
  vpc_id = aws_vpc.seoul_vpc.id
}

resource "aws_route_table_association" "seoul_public_1" {
  subnet_id      = aws_subnet.seoul_public_subnet_1.id
  route_table_id = aws_route_table.seoul_public_table.id
}

resource "aws_route_table_association" "seoul_public_2" {
  subnet_id      = aws_subnet.seoul_public_subnet_2.id
  route_table_id = aws_route_table.seoul_public_table.id
}

resource "aws_route_table_association" "seoul_public_3" {
  subnet_id      = aws_subnet.seoul_public_subnet_3.id
  route_table_id = aws_route_table.seoul_public_table.id
}
