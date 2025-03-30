# VPC
output "vpc" {
  description = "VPC id"
  value = aws_vpc.aws_vpc.id
}

locals {
  public_subnet_output = {
    for key, config in local.public_subnet: key => {
        subnet_id = aws_subnet.aws_subnet[key].id
        az = aws_subnet.aws_subnet[key].availability_zone
    }
  }

  private_subnet_output = {
    for key, config in local.private_subnet: key => {
        subnet_id = aws_subnet.aws_subnet[key].id
        az = aws_subnet.aws_subnet[key].availability_zone
    }
  }
}

output "public_subnets" {
  description = "list of public subnets"
  value = local.public_subnet_output
}

output "private_subnets" {
  description = "list of private subnets"
  value = local.private_subnet_output
}