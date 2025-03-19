locals {
  common_tags = {
    Environment = "Production"
    Owner       = "Zaid Memon"
    Project     = "Infrastructure as Code"
    ManagedBy   = "Terraform"
  }
}

resource "aws_vpc" "nginx" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "Nginx VPC"
  })
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.nginx.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = merge(local.common_tags, {
    Name = "Public Subnet"
  })
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.nginx.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = merge(local.common_tags, {
    Name = "Private Subnet"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nginx.id

  tags = merge(local.common_tags, {
    Name = "VPC Internet Gateway"
  })
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.nginx.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name = "Public Route Table"
  })
}

resource "aws_route_table_association" "public_rtb_asc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rtb.id
}
