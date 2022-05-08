resource "aws_vpc" "web_server" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "web_server" {
  vpc_id                  = aws_vpc.web_server.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.aws_az

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_internet_gateway" "web_server" {
  vpc_id = aws_vpc.web_server.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "web_server" {
  vpc_id = aws_vpc.web_server.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web_server.id
  }

  tags = {
    Name = var.rt_name
  }
}

resource "aws_route_table_association" "web_server" {
  subnet_id      = aws_subnet.web_server.id
  route_table_id = aws_route_table.web_server.id
}