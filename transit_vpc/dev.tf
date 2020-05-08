### 01 This is dev vpc settings  ###########
resource "aws_vpc" "dev_vpc" {
  cidr_block = var.dev_vpc_cidr
  tags = {
    Name = "Dev VPC"
  }
}

### 02 This is dev subnet settings  ###########
resource "aws_subnet" "dev_pub_sn" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block = var.dev_pub_sn
  availability_zone		      = lookup(var.region_az_sn, var.dev_pub_sn)
  map_public_ip_on_launch 	= "true"

  tags = {
    Name = "Dev Pub SN"
  }
}

### 03.Create-Internet-Gateway-and-Attach-to-VPC
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags =  {
    Name = "Dev IGW"
  }
}

### 04.Create-New-Route-Table-for-VPC
resource "aws_route_table" "dev_vpc_RT01" {
  vpc_id 		                = aws_vpc.dev_vpc.id
  route {
    cidr_block 		          = "0.0.0.0/0"
    gateway_id	            = aws_internet_gateway.dev_igw.id
  }
  tags = {
    Name 		            = "dev-RT-01"
    Created_By              = "Santosh"
    Created_From            = "Terrafrom"
  }
}


### 05.Assocaite-Public-Subnet-to-Route-Table
resource "aws_route_table_association" "dev_a" {
  subnet_id      	          = aws_subnet.dev_pub_sn.id
  route_table_id 	          = aws_route_table.dev_vpc_RT01.id
}

## 06.Create-Security-Group-for-VPC-Public-Instance
resource "aws_security_group" "dev_ec2_SG" {
  name        = "SG_dev_ec2"
  description = "Allow traffic only from Internet for SSH, HTTP and HTTPS"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description	= "Allow HTTP"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description	= "Allow SSH"
  }
    egress {
    from_port       	= 0
    to_port         	= 0
    protocol        	= "-1"
    cidr_blocks     	= ["0.0.0.0/0"]
    description		    = "Allow all Outgoing Traffic"
  }
  tags = {
    Name 		      = "SG_Pub_SNI_SG"
    Created_by		= "Santosh"
    Created_from	= "Terraform"
  }
}

