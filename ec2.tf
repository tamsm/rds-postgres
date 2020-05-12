// Public key material key_name -> aws console
resource "aws_key_pair" "default_key" {
  key_name = "default_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

// Latest ubuntu 18 LTS AMI id
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"] // CANONICAL
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu*18.04-amd64-server*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "app_instance" {
  ami                    = data.aws_ami.ubuntu.id
  availability_zone      = element(var.AWS_AVAILABILITY_ZONES, 0)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.default_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id              = aws_subnet.public.id
}