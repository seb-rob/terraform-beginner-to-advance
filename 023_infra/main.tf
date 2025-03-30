

# IAM USER MANAGEMENT USING TERRAFORM

# 1. Provide user and roles via YAML file
# 2. Read teh YAML file and process data
# 3. Create IAM Users
# 4. Generate passwords for the users
# 5. Attach policy/roles to each users          one extra work compare to previous work


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

# process yaml data
locals {
  users_data = yamldecode(file("./users.yaml")).users

  user_role_pair = flatten([for users in local.users_data: [for roles in users.roles: {
    username = users.username
    role = roles
  }]])
}

# create users
resource "aws_iam_user" "aws_iam_user" {
  for_each = toset(local.users_data[*].username)
  name = each.value
}

# create login details for users
resource "aws_iam_user_login_profile" "aws_iam_user_login_profile" {
  for_each = aws_iam_user.aws_iam_user
  user = each.value.name
  password_length = 12

  lifecycle {
    ignore_changes = [ 
        pgp_key,
        password_length,
        password_reset_required
     ]
  }
}


# attach policy/roles
resource "aws_iam_user_policy_attachment" "aws_iam_user_policy_attachment" {
  # baburoa-AmazonEC2FullAccess = {username: baburao, role: AmazonEC2FullAccess}
  for_each = {for pair in local.user_role_pair: "${pair.username}-${pair.role}" => pair}

  # makes sure users are created before attaching policies to user
  depends_on = [ aws_iam_user.aws_iam_user ]
  user = each.value.username
  policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
}


output "output" {
  value = local.users_data
}

output "user_role_pair" {
  value = local.user_role_pair
}