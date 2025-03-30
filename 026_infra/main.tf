
# EXPLICIT AND IMPLICIT DEPENDENCE (ec2 block)

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

resource "aws_security_group" "aws_security_group" {
  name = "my-security-group"
  ingress  {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "aws_instance" {
  ami = "ami-076c6dbba59aa92e6"
  instance_type = "t2.micro"
  tags = {
    Name = "ec2-instance"
  }

  # implicit dependency
  vpc_security_group_ids = [aws_security_group.aws_security_group.id]

  # explicit dependency
  depends_on = [ aws_security_group.aws_security_group ]
}