data "aws_vpc" "default_vpc" {
  cidr_block = "172.31.0.0/16"
  default    = true
  id         = "vpc-4e669525"
}

data "aws_subnet" "seoul_public_subnet_1" {
  vpc_id            = data.aws_vpc.default_vpc.id
  id                = "subnet-a3bc50c8"
  cidr_block        = "172.31.0.0/20"
  availability_zone = "ap-northeast-2a"
}

data "aws_subnet" "seoul_public_subnet_2" {
  vpc_id            = data.aws_vpc.default_vpc.id
  id                = "subnet-f2ab7289"
  cidr_block        = "172.31.16.0/20"
  availability_zone = "ap-northeast-2b"
}

data "aws_subnet" "seoul_public_subnet_3" {
  vpc_id            = data.aws_vpc.default_vpc.id
  id                = "subnet-ac3666e0"
  cidr_block        = "172.31.32.0/20"
  availability_zone = "ap-northeast-2c"
}

# data "aws_internet_gateway" "seoul_igw" {
#   id     = "igw-c41fb9ac"
#   vpc_id = data.aws_vpc.default_vpc.id
# }

# data "aws_route_table" "seoul_public_table" {
#   id     = "rtb-9c2890f7"
#   vpc_id = data.aws_vpc.default_vpc.id
# }

# resource "aws_route_table_association" "seoul_public_1" {
#   subnet_id      = data.aws_subnet.seoul_public_subnet_1.id
#   route_table_id = aws_route_table.seoul_public_table.id
# }

# resource "aws_route_table_association" "seoul_public_2" {
#   subnet_id      = data.aws_subnet.seoul_public_subnet_2.id
#   route_table_id = aws_route_table.seoul_public_table.id
# }

# resource "aws_route_table_association" "seoul_public_3" {
#   subnet_id      = data.aws_subnet.seoul_public_subnet_3.id
#   route_table_id = aws_route_table.seoul_public_table.id
# }
