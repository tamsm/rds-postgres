// Network Routing Rules & Gateaways defined here
// AWS elastic ip
resource "aws_eip" "app" {
  vpc        = true
  instance   = aws_instance.app_instance.id
  depends_on = [aws_internet_gateway.app]
}

// Internet Gateway for Apps's Network
resource "aws_internet_gateway" "app" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.TAG
    Environment = var.ENV
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.app.id
  }
  tags = {
    Name = "${var.TAG}_public_crt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

// Retrieve our public ip
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

// Security group -> allow ssh
resource "aws_security_group" "allow_ssh" {
  name        = "app"
  description = "The VPC security group for shared db access"
  vpc_id      = aws_vpc.main.id

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"] //Restricts to our ip
  }

 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = var.TAG
    Environment = var.ENV
  }
}

resource "aws_security_group" "db" {
  name        = "db"
  description = "Security group which allows inbound only access from public subnet"
  vpc_id      = aws_vpc.main.id

 ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public.cidr_block]
  }
  tags = {
    Name        = var.TAG
    Environment = var.ENV
  }
}


