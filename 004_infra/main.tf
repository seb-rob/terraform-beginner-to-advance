
# USE OF VARIABLES

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.0"
    }
  }
}

provider "aws" {
    region = var.region     # using variables here
}

resource "aws_instance" "server" {
    ami = "ami-05c179eced2eb9b5b"
    instance_type = "t2.micro"

    tags = {
      Name = "instance-1"
    }
}