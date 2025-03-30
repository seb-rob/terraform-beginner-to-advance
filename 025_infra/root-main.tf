

# CREATING OWN MODULE

# 1. ACCEPTS cidr_block from user to creat VPC
# 2. User can create multiple subnets
#  2.1 Get CIDR_blcok for subnets from user
#    2.2 Get AZs (avaialability zone)
#    2.3 User can mark a subnet as public (default is private)
#        2.3.1 if public, create IGW
#        2.3.2 Associate public subnet with routing table


provider "aws" {
  region = "ap-south-1"
}


module "vpc_module" {
  source = "./modules/vpc"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name = "own_vpc_module"
  }

  # subnets
  subnet_config = {
    private_subnet = {
      cidr_block = "10.0.0.0/24"
      az = "ap-south-1a"
    }
    public_subnet = {
      cidr_block = "10.0.1.0/24"
      az = "ap-south-1a"
      public = true
    }
    public_subnet-1 = {
      cidr_block = "10.0.2.0/24"
      az = "ap-south-1a"
      public = true
    }
  }
}