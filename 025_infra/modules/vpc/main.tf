# create vpc
resource "aws_vpc" "aws_vpc" {
  cidr_block = var.vpc_config.cidr_block
  tags = {
    Name = var.vpc_config.name
  }
}

# create subnet
resource "aws_subnet" "aws_subnet" {
  vpc_id = aws_vpc.aws_vpc.id
  for_each = var.subnet_config
  cidr_block = each.value.cidr_block
  availability_zone = each.value.az
  tags = {
    Name = each.key
  }
}

locals {
  # if subnet has public = true
  public_subnet = { for key, config in var.subnet_config: key => config if config.public }

  # if subnet has public = false
  private_subnet = { for key, config in var.subnet_config: key => config if !config.public }
}


# create internet_gateway only if public = true in subnet
resource "aws_internet_gateway" "aws_internet_gateway" {
  vpc_id = aws_vpc.aws_vpc.id
  count = length(local.public_subnet) > 0 ? 1 : 0
  tags = {
    Name = "internet_gateway"
  }
}


# create route table only if there is public subnet
resource "aws_route_table" "aws_route_table" {
  vpc_id = aws_vpc.aws_vpc.id
  count = length(local.public_subnet) > 0 ? 1 : 0
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_internet_gateway[0].id
  }
}


# rotue table association
resource "aws_route_table_association" "aws_route_table_association" {
  # to connect each and every public subnet to route table
  for_each = local.public_subnet
  subnet_id = aws_subnet.aws_subnet[each.key].id
  route_table_id = aws_route_table.aws_route_table[0].id
}
