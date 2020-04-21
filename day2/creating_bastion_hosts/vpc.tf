# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "Bation VPC"
  }
}

# Subnets
resource "aws_subnet" "var_main_pub_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "var_main_pub_1"
  }
}

resource "aws_subnet" "var_main_pub_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "var_main_pub_2"
  }
}

resource "aws_subnet" "var_main_pub_3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1c"

  tags = {
    Name = "var_main_pub_3"
  }
}

resource "aws_subnet" "var_main_pri_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "var_main_pri_1"
  }
}

resource "aws_subnet" "var_main_pri_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "var_main_pri_2"
  }
}

resource "aws_subnet" "var_main_pri_3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-1c"

  tags = {
    Name = "var_main_pri_3"
  }
}

# Internet GW
resource "aws_internet_gateway" "var_main_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# route tables
resource "aws_route_table" "var_main_public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.var_main_igw.id
  }

  tags = {
    Name = "var_main_pub_1"
  }
}

# route associations public
resource "aws_route_table_association" "var_main_pub_1-a" {
  subnet_id      = aws_subnet.var_main_pub_1.id
  route_table_id = aws_route_table.var_main_public.id
}

resource "aws_route_table_association" "var_main_pub_2-a" {
  subnet_id      = aws_subnet.var_main_pub_2.id
  route_table_id = aws_route_table.var_main_public.id
}

resource "aws_route_table_association" "var_main_pub_3-a" {
  subnet_id      = aws_subnet.var_main_pub_3.id
  route_table_id = aws_route_table.var_main_public.id
}

