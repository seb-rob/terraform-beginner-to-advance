
# USE OF RANDOM_ID TO GET RANDOME IDS FOR BUCKET

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.0"
    }
    random = {
        source = "hashicorp/random"
        version = "3.7.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}


# getting random id
resource "random_id" "rand_id" {
  byte_length = 8
}


resource "aws_s3_bucket" "demo-bucket" {
  bucket = "my-bucket-${random_id.rand_id.hex}"     # using random_id
}


# storing random id
output "random" {
  value = random_id.rand_id.hex
}