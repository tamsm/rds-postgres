// VPC's & Subnet definitions here
resource "aws_vpc" "main" {
  cidr_block           =  var.IP_RANGE
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = var.TAG
  }
}


locals {
  zones_count = length(var.AWS_AVAILABILITY_ZONES)
}

//private subnets
resource "aws_subnet" "private" {
  count                   = local.zones_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.IP_RANGE,4,count.index)
  availability_zone       = element(var.AWS_AVAILABILITY_ZONES, count.index)
  tags = {
      Name = ".${var.TAG}-private"
  }
}

//public subnets
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.IP_RANGE,4 ,2)
  map_public_ip_on_launch = true
  availability_zone       = element(var.AWS_AVAILABILITY_ZONES,0)

  tags = {
      Name = "${var.TAG}-public"
  }
}

// db subnet group for RDS service
resource "aws_db_subnet_group" "postgres" {
  subnet_ids = aws_subnet.private.*.id
}
