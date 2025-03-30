
# TERRAFORM VARIABLES

# environment var       |
# terraform.tfvars      | # arrow shows how priority level increases for varibles
# *.auto.tfvars         |
# -var & -var-file      |
#                       V

# export TF_VAR_key = value

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.91"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "aws_instance" {
  ami = "ami-05c179eced2eb9b5b"
  instance_type = var.aws_instance_type

  # before using map @additional_tags
#   tags = {
#     Name = "aws_instance"
#   }

  # after using map @additonal_tags
  tags = merge(var.additional_tags, {
    Name = "aws_intance"
  })

  # see how this below block can be replaced object variables
#   root_block_device {
#     delete_on_termination = true
#     volume_size = var.root_volume_size
#     volume_type = var.root_volume_type
#   }


  # after replacing with new object type
  root_block_device {
    delete_on_termination = local.delete_on_termination     # uses local variables
    volume_size = var.ec2_config.volume_size
    volume_type = var.ec2_config.volume_type
  }
}