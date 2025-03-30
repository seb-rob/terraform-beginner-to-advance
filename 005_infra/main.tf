
# DYNAMICALLY STORING THE DETAILS OF EC2 INSTANCE IN OUTPUT.TF

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "mern-server-1" {
  ami = "ami-05c179eced2eb9b5b"
  instance_type = "t2.micro"
  tags = {
    Name = "instance-1"
  }
}