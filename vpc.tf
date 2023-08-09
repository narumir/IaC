data "aws_vpc" "default_vpc" {
  cidr_block = "172.31.0.0/16"
  default    = true
  id         = "vpc-4e669525"
}

data "aws_subnet" "seoul_public_subnet_1" {
  vpc_id            = data.aws_vpc.default_vpc.id
  id                = "subnet-a3bc50c8"
  cidr_block        = "172.31.0.0/20"
  ipv6_cidr_block   = "2406:da12:c86:4300::/64"
  availability_zone = "ap-northeast-2a"
}

data "aws_subnet" "seoul_public_subnet_2" {
  vpc_id            = data.aws_vpc.default_vpc.id
  id                = "subnet-f2ab7289"
  cidr_block        = "172.31.16.0/20"
  ipv6_cidr_block   = "2406:da12:c86:4301::/64"
  availability_zone = "ap-northeast-2b"
}

data "aws_subnet" "seoul_public_subnet_3" {
  vpc_id            = data.aws_vpc.default_vpc.id
  id                = "subnet-ac3666e0"
  cidr_block        = "172.31.32.0/20"
  ipv6_cidr_block   = "2406:da12:c86:4302::/64"
  availability_zone = "ap-northeast-2c"
}
