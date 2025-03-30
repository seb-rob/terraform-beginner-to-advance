# terraform-aws-vpc

## Overview
This Terraform module creates an AWS VPC with a given CIDR block. It also creates multiples subnets (public and private), and for public subnets, it sets up an Internet Gateway (IGW) and appropriate route tables.

## Features
- Create a VPC with a specified CIDR block
- Creates public and private subnets
- Creates an Internet Gateway (IGW) for public subnets
- sets up route tables for public subnets

## Usage
```
provider "aws" {
  region = "your_region"
}


module "vpc_module" {
  source = "./modules/vpc"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name = "your_vpc_name"
  }

  # subnets
  subnet_config = {
    private_subnet = {
      cidr_block = "10.0.0.0/24"
      az = "availability zones"
    }
    public_subnet = {
      cidr_block = "10.0.1.0/24"
      az = "availability zones"
      public = true
    }
    public_subnet-1 = {
      cidr_block = "10.0.2.0/24"
      az = "availability zones"
      public = true
    }
  }
}
```