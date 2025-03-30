
# CREATE MULTIPLE INSTANCE WITH DIFFERENT NAMES

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "server" {
  ami = "ami-05c179eced2eb9b5b"
  instance_type = "t2.micro"
  count = 3

  tags = {
    Name = "instance-${count.index+1}"
  }
}