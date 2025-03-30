
# CREATE S3 BUCKET AND UPLOAD FILE

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

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "oaidjfuetasj78"
}

resource "aws_s3_object" "file_pload" {
  bucket = aws_s3_bucket.demo-bucket.bucket
  source = "./temporary_file.txt"
  key = "temporary_file.txt"
}