
# TERRAFORM LIFECYCLE

# 1. create_before_destroy = true
# This setting ensures that Terraform creates a new resource before destroying the old one. This is useful when you want to avoid downtime during resource replacement.
# For example, if you have an EC2 instance running with an Amazon Linux AMI, and you want to change the AMI to Ubuntu, Terraform will by default destroy the current EC2 instance and create a new one with the new AMI. However, by setting create_before_destroy = true, Terraform will first create the new EC2 instance with the Ubuntu AMI, and only after it’s successfully running will it destroy the old Amazon Linux instance. This prevents any downtime for the EC2 instance.


# 2. prevent_destroy = true
# ensures that Terraform will not destroy the resource under any circumstance. If you attempt to modify the resource in such a way that Terraform would destroy it (for example, changing a property that would normally lead to the resource being destroyed), Terraform will throw an error and prevent the destruction from happening.
# It acts as a safeguard to protect critical resources from accidental deletion.
# Example Use Case:
# Let’s say you have a critical EC2 instance running that you don't want to be destroyed even if Terraform tries to apply changes that would normally lead to its destruction (e.g., changing the AMI or instance type). You can apply prevent_destroy = true to this instance to ensure that no one (including yourself) can destroy it without removing the lifecycle constraint first.

# 3. ignore_change
# ignore_changes: This is a list of resource attributes that Terraform should ignore during the comparison between the desired state (as defined in the configuration) and the current state (as stored in the state file). When you modify these attributes in your configuration, Terraform will not attempt to update the resource to match the configuration on the next terraform apply or terraform plan.

# password_length: If the password_length attribute is changed in your configuration file, Terraform will not try to update the resource. It will leave the existing value intact.

# password_reset_required: If you change this attribute in the configuration, Terraform will ignore the change and leave the value unchanged for the resource.

# pgp_key: Similarly, changes to the pgp_key attribute will be ignored by Terraform, meaning Terraform will not update or re-encrypt the resource based on any modifications to this attribute.

# 4. replace_triggered_by: [list_of_items]
# In Terraform, the replace_triggered_by lifecycle argument is used to explicitly trigger the replacement of a resource if certain other resources or attributes change. This is helpful when you want to force a resource to be replaced due to changes in resources it depends on, or changes to certain attributes.

# replace_triggered_by = [aws_security_group.aws_security_group, aws_security_group.aws_security_group.ingress]:

# What it means: If either the security group itself or the ingress rule inside the security group changes, it will force a replacement of the aws_instance.

# Essentially, this tells Terraform that the EC2 instance (aws_instance.aws_instance) should be replaced if there is a change in the aws_security_group.aws_security_group resource or its ingress block.



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

resource "aws_security_group" "aws_security_group"{
  name = "my-security-group"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "aws_instance" {
  ami = "ami-076c6dbba59aa92e6"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.aws_security_group.id]
  depends_on = [ aws_security_group.aws_security_group ]

  lifecycle {
    # create_before_destroy = true
    # prevent_destroy = true
    replace_triggered_by = [ aws_security_group.aws_security_group, aws_security_group.aws_security_group.ingress]
  }
}


# create user
resource "aws_iam_user" "aws_iam_user" {
  name = "srr-tf-user"
}

# create login profile 
resource "aws_iam_user_login_profile"  "aws_iam_user_login_profile" {
    user = aws_iam_user.aws_iam_user.name
    password_length = 12

    lifecycle {
      ignore_changes = [ 
        password_length,
        password_reset_required,
        pgp_key
       ]
    }
}