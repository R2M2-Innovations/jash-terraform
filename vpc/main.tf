resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block 
  enable_dns_support = var.enable_dns_support 
  enable_dns_hostnames = var.enable_dns_hostnames 

  tags = merge(
    local.common_tags,
    {
      "Name" = "${var.organization}-${var.environment}-${var.stack_id}"
    }
  )
}

resource "aws_internet_gateway" "internet_gateway" {
  count = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      "Name" = "${var.organization}-${var.environment}-${var.stack_id}"
    }
  )
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.vpc.id
  availability_zone = "${var.region}${element(split(",", element(var.public_subnets, count.index)), 0)}"
  cidr_block = element(split(",", element(var.public_subnets, count.index)), 1) 
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      "Name" = "${var.organization}-${element(split(",", element(var.public_subnets, count.index)), 2)}-${var.environment}-${var.stack_id}${element(split(",", element(var.public_subnets, count.index)), 0)}"
    }
  )
}

resource "aws_route_table" "public_route" {
  count = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway[0].id
  }

  tags = merge(
    local.common_tags,
    {
      "Name" = "${var.organization}-${var.environment}-${var.stack_id}-igw"
    }
  )
}

resource "aws_route_table_association" "public_route_table_association" {
  count = length(var.public_subnets)
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route[0].id
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.vpc.id
  availability_zone = "${var.region}${element(split(",", element(var.private_subnets, count.index)), 0)}"
  cidr_block = element(split(",", element(var.private_subnets, count.index)), 1) 

  tags = merge(
    local.common_tags,
    {
      "Name" = "${var.organization}-${element(split(",", element(var.private_subnets, count.index)), 2)}-${var.environment}-${var.stack_id}${element(split(",", element(var.private_subnets, count.index)), 0)}"
    }
  )
}

resource "aws_eip" "nat_eip" {
  count = var.deploy_nat_gateways ? length(var.public_subnets) : 0
  vpc      = true
}

resource "aws_nat_gateway" "nat_gateway" {
  count = var.deploy_nat_gateways ? length(var.public_subnets) : 0
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)

  tags = merge(
    local.common_tags,
    {   
      "Name" = "${var.organization}-${element(split(",", element(var.public_subnets, count.index)), 2)}-${var.environment}-${var.stack_id}${element(split(",", element(var.public_subnets, count.index)), 0)}"
    }   
  )
}

resource "aws_route_table" "private_route" {
  count = var.deploy_nat_gateways ? length(var.public_subnets) : 0
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gateway.*.id, count.index)
  }

  tags = merge(
    local.common_tags,
    {
      "Name" = "${var.organization}-${element(split(",", element(var.private_subnets, count.index)), 2)}-${var.environment}-${var.stack_id}${element(split(",", element(var.private_subnets, count.index)), 0)}-ngw"
    }
  )

  provisioner "local-exec" {
    command = "scripts/associate-private-routes.sh ${aws_vpc.vpc.id} ${var.region}"
  }
}
