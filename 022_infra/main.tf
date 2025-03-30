

# IAM USER MANAGEMENT USING TERRAFORM

# 1. Provide user and roles via YAML file
# 2. Read teh YAML file and process data
# 3. Create IAM Users
# 4. Generate passwords for the users


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

# read data from yaml
locals {
  users_data = yamldecode(file("./users.yaml")).users
}

# create users
resource "aws_iam_user" "aws_iam_user" {
  for_each = toset(local.users_data[*].username)
  name = each.value
}

# create login details for above users
resource "aws_iam_user_login_profile" "aws_iam_user_login_profile" {
  for_each = aws_iam_user.aws_iam_user
  user = each.value.name
  password_length = 12
  
  lifecycle {
    ignore_changes = [ 
        password_length,
        password_reset_required,
        pgp_key
     ]
  }
}


output "output" {
  value = local.users_data
}