
# MULTIPLE RESOURCES USING COUNT AND FOR_EACH
# SITUATION: 
# CREATE A VPC AND TWO SUBNETS WITH DIFFERENT NAMES AND CIDR_BLOCK BUT USING ONE RESOURCE BLOCK

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.92"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "aws_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "aws_vpc"
  }
}

resource "aws_subnet" "aws_subnet" {
  vpc_id = aws_vpc.aws_vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count = 2
  tags = {
    Name = "subnet-${count.index}"
  }
}

output "created_subnets_are" {
  # for single subnet access
  # value = aws_subnet.aws_subnet[0].id

  # to access all subnet with details
  value = [for subnet in aws_subnet.aws_subnet: subnet]
}