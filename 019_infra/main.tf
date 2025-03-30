
# MULTIPLE RESOURCES USING COUNT AND FOR_EACH
# SITUATION: 
# CREATE A VPC AND TWO SUBNETS WITH DIFFERENT NAMES AND CIDR_BLOCK
# CREATE 4 EC2 INSTANCE ASSIGNED TWO SUBNETS EACH

terraform {
  required_providers{
    aws = {
        version = "5.92"
        source = "hashicorp/aws"
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
  count = 2
  cidr_block = "10.0.${count.index}.0/24"
  tags = {
    Name = "subnet-${count.index}"
  }
}

resource "aws_instance" "aws_instance" {
  ami = "ami-05c179eced2eb9b5b"
  instance_type = "t2.micro"
  # by default not assigned
  associate_public_ip_address = true
  
  count = 4
  subnet_id = element(aws_subnet.aws_subnet[*].id, count.index % length(aws_subnet.aws_subnet))

  tags = {
    Name = "ec2-instance-${count.index}"
  }
}

output "subnet_ids" {
  value = [for subnet in aws_subnet.aws_subnet: subnet.id]
}

output "instance_ips" {
  value = [for ips in aws_instance.aws_instance: ips.public_ip]
}

