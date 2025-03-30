terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my-simple-server" {
  ami = "ami-05c179eced2eb9b5b"
  instance_type = "t2.micro"

  tags = {
    Name = "my-sample-server"
  }
}