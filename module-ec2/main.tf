#--- module-ec2/main.tf 

# Create aws ec2 instance for the app server
resource "aws_instance" "my_app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    Name = "EC2-App-Server"
  }
}

resource "aws_vpc" "myvpc_main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "myvpc-main"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.myvpc_main.id
  cidr_block = var.cidr
  availability_zone = var.az
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}
resource "aws_security_group" "allow_http" {
  name        = "allow-http"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.myvpc_main.id
  
  ingress {
    description      = "http allowed"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-http"
  }
}
