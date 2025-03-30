
# HOST STATIC WEB SITE THROUGH S3 BUCKET

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.0"
    }
  }
  
  # store state file remotely
  # backend "s3" {
  #   bucket = output.backend
  #   key = "backend.tfstate"
  # }
}

provider "aws" {
  region = "ap-south-1"
}

# craete random id for bucket
resource "random_id" "random_hex" {
  byte_length = 8
}

# create bucket
resource "aws_s3_bucket" "buck" {
  bucket = "bucket-${random_id.random_hex.hex}"
}

# add index.html to your bucket
resource "aws_s3_object" "upload_files" {
  bucket = aws_s3_bucket.buck.id
  key = "index.html"
  source = "./index.html"
  content_type = "text/html"
}

# disable public access
resource "aws_s3_bucket_public_access_block" "off_public_access" {
  bucket = aws_s3_bucket.buck.id
  block_public_acls = false
  block_public_policy = false
  restrict_public_buckets = false
  ignore_public_acls = false
}

# configuring website
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.buck.id
  index_document {
    suffix = "index.html"
  }
}

# adding policy to bucket
resource "aws_s3_bucket_policy" "add_policy" {
  bucket = aws_s3_bucket.buck.id
  policy = jsonencode({
    Statement = [
        {
            Sid ="PublicReadGetObject",
            Effect = "Allow",
            Principal = "*",
            Action = "s3:GetObject",
            Resource = "arn:aws:s3:::${aws_s3_bucket.buck.id}/*"
        }
    ]
  })
}


# link to hosted website
output "website_link" {
  value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}

# get bucket's uniqe id for backend remote state management
output "backend" {
  value = aws_s3_bucket.buck.id
}