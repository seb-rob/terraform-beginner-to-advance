
# MULTIPLE RESOURCES USING COUNT AND FOR_EACH
# SITUATION: 
# CREATE A VPC AND TWO SUBNETS WITH DIFFERENT NAMES AND CIDR_BLOCK
# CREATE 2 EC2 INSTANCE ASSIGNED TWO SUBNETS EACH BUT DIFFERENT AMI IDS FOR EC2
# UBUNTU, AMAZON-LINUX
# USING FOR_EACH


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
  count = 2
  cidr_block = "10.0.${count.index}.0/24"
  tags = {
    Name = "subnet-${count.index}"
  }
}

resource "aws_instance" "aws_instance" {
  for_each = var.ec2_map
  ami = each.value.ami
  instance_type = each.value.instance_type
  associate_public_ip_address = true
  subnet_id = element(aws_subnet.aws_subnet[*].id, index(keys(var.ec2_map), each.key) % length(aws_subnet.aws_subnet))

  tags = {
    Name = "aws-ec2-${each.key}-instance"
  }
}


output "subnet_ids" {
  value = [for subnets in aws_subnet.aws_subnet: subnets.id]
}

output "public_ips" {
  value = [for ips in aws_instance.aws_instance: ips.public_ip]
}