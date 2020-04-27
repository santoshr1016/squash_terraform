#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#
### 01.Create-Base-VPC
resource "aws_vpc" "vpcAWSEKS01" {
  cidr_block 		            = var.cidr
  instance_tenancy 	        = "default"

  tags = map(
  "Name", "${var.EKS_Cluster_Name}-VPC",
  "kubernetes.io/cluster/${var.EKS_Cluster_Name}", "shared",
  )
}

### 02.Create-VPC-Subnets
### 02.1.Creating-Public-Subnet-01
resource "aws_subnet" "vpcAWSEKS01PubSN01" {
  vpc_id     			          = aws_vpc.vpcAWSEKS01.id
  cidr_block 			          = var.public_subnet_1
  availability_zone		      = lookup(var.region_az_sn, var.public_subnet_1)
  map_public_ip_on_launch 	= "true"

  tags = map(
  "Name", "${var.EKS_Cluster_Name}-node",
  "kubernetes.io/cluster/${var.EKS_Cluster_Name}", "shared",
  )
}

### 02.2.Creating-Public-Subnet-02
resource "aws_subnet" "vpcAWSEKS01PubSN02" {
  vpc_id     			          = aws_vpc.vpcAWSEKS01.id
  cidr_block 			          = var.public_subnet_2
  availability_zone		      = lookup(var.region_az_sn, var.public_subnet_2)
  map_public_ip_on_launch 	= "true"

  tags = map(
  "Name", "${var.EKS_Cluster_Name}-node",
  "kubernetes.io/cluster/${var.EKS_Cluster_Name}", "shared",
  )
}

### 02.3.Creating-Public-Subnet-03
resource "aws_subnet" "vpcAWSEKS01PubSN03" {
  vpc_id     			          = aws_vpc.vpcAWSEKS01.id
  cidr_block 			          = var.public_subnet_3
  availability_zone		      = lookup(var.region_az_sn, var.public_subnet_3)
  map_public_ip_on_launch 	= "true"

  tags = map(
  "Name", "${var.EKS_Cluster_Name}-node",
  "kubernetes.io/cluster/${var.EKS_Cluster_Name}", "shared",
  )
}

### 02.4.Creating-Private-Subnet-01
resource "aws_subnet" "vpcAWSEKS01PriSN01" {
  vpc_id     			          = aws_vpc.vpcAWSEKS01.id
  cidr_block 			          = var.private_subnet_1
  availability_zone		      = lookup(var.region_az_sn, var.private_subnet_1)
  map_public_ip_on_launch 	= "false"

  tags = map(
  "Name", "${var.EKS_Cluster_Name}-node",
  "kubernetes.io/cluster/${var.EKS_Cluster_Name}", "shared",
  )
}

### 02.5.Creating-Private-Subnet-02
############################################################################

resource "aws_subnet" "vpcAWSEKS01PriSN02" {
  vpc_id     			          = aws_vpc.vpcAWSEKS01.id
  cidr_block 			          = var.private_subnet_2
  availability_zone		      = lookup(var.region_az_sn, var.private_subnet_2)
  map_public_ip_on_launch 	= "false"

  tags = map(
  "Name", "${var.EKS_Cluster_Name}-node",
  "kubernetes.io/cluster/${var.EKS_Cluster_Name}", "shared",
  )
}

### 02.6.Creating-Private-Subnet-03
############################################################################

resource "aws_subnet" "vpcAWSEKS01PriSN03" {
  vpc_id     			          = aws_vpc.vpcAWSEKS01.id
  cidr_block 			          = var.private_subnet_3
  availability_zone		      = lookup(var.region_az_sn, var.private_subnet_3)
  map_public_ip_on_launch 	= "false"

  tags = map(
  "Name", "${var.EKS_Cluster_Name}-node",
  "kubernetes.io/cluster/${var.EKS_Cluster_Name}", "shared",
  )
}

### 03.Create-Internet-Gateway-and-Attach-to-VPC
resource "aws_internet_gateway" "vpcAWSEKS01IG" {
  vpc_id 		                = aws_vpc.vpcAWSEKS01.id

  tags =  {
    Name = var.EKS_Cluster_Name
  }
}

### 04.Create-New-Route-Table-for-VPC
resource "aws_route_table" "vpcAWSEKS01RT01" {
  vpc_id 		                = aws_vpc.vpcAWSEKS01.id

  route {
    cidr_block 		          = "0.0.0.0/0"
    gateway_id	            = aws_internet_gateway.vpcAWSEKS01IG.id
  }

  tags = {
    Name 		            = "vpc-AWS-EKS-01-RT-01"
    Created_By              = "Santosh"
    Created_From            = "Terrafrom"
  }
}


### 04.1.Assocaite-Public-Subnet-to-Route-Table
############################################################################
resource "aws_route_table_association" "a" {
  subnet_id      	          = aws_subnet.vpcAWSEKS01PubSN01.id
  route_table_id 	          = aws_route_table.vpcAWSEKS01RT01.id
}

resource "aws_route_table_association" "a2" {
  subnet_id      	          = aws_subnet.vpcAWSEKS01PubSN02.id
  route_table_id 	          = aws_route_table.vpcAWSEKS01RT01.id
}

resource "aws_route_table_association" "a3" {
  subnet_id      	          = aws_subnet.vpcAWSEKS01PubSN03.id
  route_table_id 	          = aws_route_table.vpcAWSEKS01RT01.id
}

## 05.Create-Security-Group-for-VPC-Private-Instance
resource "aws_security_group" "vpcAWSEKS01PriSNISG" {
  name                       = "vpcAWSPoCEKS01PriSNISG"
  description                = "Allow traffic only from Public Subnet"
  vpc_id                     = aws_vpc.vpcAWSEKS01.id

  ingress {
    from_port               = 80
    to_port                 = 80
    protocol                = "TCP"
    cidr_blocks             = [aws_subnet.vpcAWSEKS01PubSN01.cidr_block,aws_subnet.vpcAWSEKS01PubSN02.cidr_block,aws_subnet.vpcAWSEKS01PubSN03.cidr_block]
    description             = "Allow HTTP"
  }

  ingress {
    from_port               = 8080
    to_port                 = 8080
    protocol                = "TCP"
    cidr_blocks             = [aws_subnet.vpcAWSEKS01PubSN01.cidr_block,aws_subnet.vpcAWSEKS01PubSN02.cidr_block,aws_subnet.vpcAWSEKS01PubSN03.cidr_block]
    description             = "Allow HTTP"
  }


  ingress {
    from_port               = 443
    to_port                 = 443
    protocol                = "TCP"
    cidr_blocks             = [aws_subnet.vpcAWSEKS01PubSN01.cidr_block,aws_subnet.vpcAWSEKS01PubSN02.cidr_block,aws_subnet.vpcAWSEKS01PubSN03.cidr_block]
    description             = "Allow HTTPS"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [aws_subnet.vpcAWSEKS01PubSN01.cidr_block,aws_subnet.vpcAWSEKS01PubSN02.cidr_block,aws_subnet.vpcAWSEKS01PubSN03.cidr_block]
    description = "Allow SSH"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [aws_subnet.vpcAWSEKS01PubSN01.cidr_block,aws_subnet.vpcAWSEKS01PubSN02.cidr_block,aws_subnet.vpcAWSEKS01PubSN03.cidr_block]
    description = "Allow ICMP PING"
  }

  egress {
    from_port       	= 0
    to_port         	= 0
    protocol        	= "-1"
    cidr_blocks     	= ["0.0.0.0/0"]
    description      	= "Allow all Outgoing traffic"
  }

  tags = {
    Name 		      = "vpcAWSEKS01PriSNI_SG"
    Created_by		= "Santosh"
    Created_from	= "Terraform"
  }
}

## 06.Create-Security-Group-for-VPC-Public-Instance
resource "aws_security_group" "vpcAWSEKS01PubSNISG" {
  name        = "vpcAWSPoCEKS01PubSNISG"
  description = "Allow traffic only from Internet for SSH, HTTP and HTTPS"
  vpc_id      = aws_vpc.vpcAWSEKS01.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description	= "Allow HTTP"
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description	= "Allow HTTPS"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description	= "Allow SSH"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    description	= "Allow ICMP Ping"
  }

  egress {
    from_port       	= 0
    to_port         	= 0
    protocol        	= "-1"
    cidr_blocks     	= ["0.0.0.0/0"]
    description		    = "Allow all Outgoing Traffic"
  }

  tags = {
    Name 		      = "vpcAWSEKS01-Pub-SNI-SG"
    Created_by		= "Santosh"
    Created_from	= "Terraform"
  }
}
