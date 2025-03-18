terraform {
  # required_version = "some ver"

  # We can use "backend" block for configuring a state backend
  # backend "s3" {
  # }

  # We cant use variables or any references inside terraform block. only constants are allowed. 

  # We can use "cloud" block for configuring Terraform Cloud

  # version constraints
  # = that exact version
  # != excludes an exact version
  # >=, <=, >, < allows versions for which comparison is true
  # ~> allows only the rightmost digit to increment

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "demo_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "Terraform VPC Demo"
    Environment = "Development"
    Owner       = "Zaid Memon"
    Project     = "Infrastructure as Code"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.demo_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name        = "Public Subnet"
    Environment = "Development"
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.demo_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name        = "Private Subnet"
    Environment = "Development"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "VPC Internet Gateway"
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rtb.id
}
