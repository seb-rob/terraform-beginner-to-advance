# VPC output from module vpc_module
output "vpc"{
    value = module.vpc_module.vpc
}

# public subnets from vpc_module
output "root_public_subnets" {
  value = module.vpc_module.public_subnets
}

# private subnets from vpc_module
output "root_private_subnets" {
  value = module.vpc_module.private_subnets
}