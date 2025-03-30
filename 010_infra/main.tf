
# CREATE VIRTUAL PRIVATE NETWORK (VPC)

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# crate vpc
resource "aws_vpc" "aws_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "aws_vpc"
  }
}

# create subnet (private)
resource "aws_subnet" "aws_subnet_private" {
  vpc_id = aws_vpc.aws_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "aws_subnet_private"
  }
}

# create subnet (public)
resource "aws_subnet" "aws_subnet_public" {
  vpc_id = aws_vpc.aws_vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "aws_subnet_public"
  }
}

# create internet gateway
resource "aws_internet_gateway" "aws_internet_gateway" {
  vpc_id = aws_vpc.aws_vpc.id
  tags = {
    Name = "aws_internet_gateway"
  }
}

# create route table
resource "aws_route_table" "aws_route_table" {
  vpc_id = aws_vpc.aws_vpc.id
  tags = {
    Name = "aws_route_table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_internet_gateway.id
  }
}

# associate public subnet and route table 
resource "aws_route_table_association" "aws_route_table_association" {
  route_table_id = aws_route_table.aws_route_table.id
  subnet_id = aws_subnet.aws_subnet_public.id
}