# Setting up VPC

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cdir
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terralearn_vpc"
  }
}

# Set up public and private subnets

resource "aws_subnet" "vpc_public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.vpc_public_subnet)
  cidr_block        = element(var.vpc_public_subnet, count.index)
  availability_zone = element(var.vpc_subnets_availability_zone, count.index)

  tags = {
    Name = "terralearn_subnet_public_${count.index + 1}"
  }
}

resource "aws_subnet" "vpc_private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.vpc_private_subnet)
  cidr_block        = element(var.vpc_private_subnet, count.index)
  availability_zone = element(var.vpc_subnets_availability_zone, count.index)

  tags = {
    Name = "terralearn_subnet_private_${count.index + 1}"
  }
}

# Set up internet gateway for public subnets

resource "aws_internet_gateway" "vpc_internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "terralearn_vpc_internet_gateway"
  }
}

# Setting up rout tables for networks

# Private rt

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.vpc_private_subnet)

  tags = {
    Name = "terralearn_private_network_rt_${count.index + 1}"
  }
}

resource "aws_route_table_association" "private_association" {
  count          = length(var.vpc_private_subnet)
  subnet_id      = aws_subnet.vpc_private_subnet[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# Public rt

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_internet_gateway.id
  }

  tags = {
    Name = "terralearn_public_network_rt"
  }
}

resource "aws_route_table_association" "public_association" {
  count          = length(var.vpc_public_subnet)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.vpc_public_subnet[count.index].id
}
