
# EXAMPLE OF DATA SOURCES

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

# get caller's details
data "aws_caller_identity" "aws_caller_identity" {
  
}

# output caller's details
output "aws_caller_identity" {
  value = data.aws_caller_identity.aws_caller_identity
}




# get instances if available
data "aws_instance" "aws_instance" {
  
}

# output instance if data block encounters any available instance
output "aws_instance" {
  value = data.aws_instance.aws_instance
}




# get vpc
data "aws_vpc" "aws_vpc"{

}

# output vpc details
output "aws_vpc" {
  value = data.aws_vpc.aws_vpc
}



# get security groups
data "aws_security_group" "aws_security_group" {
  
}

# output security group
output "aws_security_group" {
  value = data.aws_security_group.aws_security_group
}



# get available key pairs
data "aws_key_pair" "aws_key_pair" {
  
}

# output key pairs
output "aws_key_pair" {
  value = data.aws_key_pair.aws_key_pair
}



# get ami's
data "aws_ami" "aws_ami" {
  most_recent = true
  owners = ["amazon", "microsoft"]
}

# output ami's
output "aws_ami" {
  value = data.aws_ami.aws_ami
}



# get ami ids
data "aws_ami_ids" "aws_ami_ids" {
  owners = ["amazon", "microsoft"]
}

# output ami ids
output "aws_ami_ids" {
  value = data.aws_ami.aws_ami
}




# get regions
data "aws_region" "aws_region" {
  
}

# output region details
output "aws_region" {
  value = data.aws_region.aws_region
}



# get availability zones
data "aws_availability_zone" "aws_availability_zone" {
  
}

# output availability zones
output "aws_availability_zone" {
  value = data.aws_availability_zone.aws_availability_zone
}