

# THIS SHOWS HOW TO USE MODULES UPLOAD AT https://registry.terraform.io/
# FOR VPC MODULES CODE and FOLDER STRUCTURE, CHECK .terraform FOLDER


provider "aws" {
  region = "ap-south-1"
}

data "aws_availability_zones" "aws_availability_zones" {
  state = "available"
}

# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  azs = data.aws_availability_zones.aws_availability_zones.names
  private_subnets = ["10.0.0.0/24"]
  public_subnets = ["10.0.1.0/24"]
  tags = {
    Name = "aws_vpc_module"
  }
}


# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.1"

  ami = "ami-076c6dbba59aa92e6"                                     # default input is null found from docs section -> input
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]   # default_security_group_id found from docs section-> output of vpc module
  subnet_id              = module.vpc.public_subnets[0]             # as list was given

  tags = {
    Name = "ec2"
  }

}



# output "vpcs" {
#   value = data.aws_availability_zones.aws_availability_zones.names
# }