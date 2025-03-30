
# REMOTELY STATE MANAGEMENT
# IT STORES THE terraform.tfstate file to s3
# SO THAT OTHER DEVELOPERS CAN SEE AND get UPDATED STATE FILE

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.0"
    }
  }
  backend "s3" {
    key = "backend.tfstate"
    bucket = "my-bucket-519373ea32371ab8"       # active S3 bucket name
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "server" {
  ami = "ami-05c179eced2eb9b5b"
  instance_type = "t2.micro"
}