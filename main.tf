# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Configure the AWS VPC
resource "aws_vpc" "jisellevpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "jisellevpc"
  }
}

# Configure 2 public subnets
resource "aws_subnet" "public_1" {
  vpc_id                  = "vpc-007ead90ae7468f2e"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnet_1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = "vpc-007ead90ae7468f2e"
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnet_2"
  }
}

# Configure 2 private subnets
resource "aws_subnet" "private_1" {
  vpc_id                  = "vpc-007ead90ae7468f2e"
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private_Subnet_1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id                  = "vpc-007ead90ae7468f2e"
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private_Subnet_2"
  }
}

resource "aws_internet_gateway" "ig" {
  tags = {
    Name = "main"
  }
  vpc_id = "vpc-007ead90ae7468f2e"
}


# Create route table to internet gateway
resource "aws_route_table" "project_rt" {
  vpc_id = "vpc-007ead90ae7468f2e"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-0e157466e3646fcf7"
  }
  tags = {
    Name = "project-rt"
  }
}



# Associate public subnets with route table
resource "aws_route_table_association" "public_route_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.project_rt.id
}

resource "aws_route_table_association" "public_route_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.project_rt.id
}





# Create security groups
resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Allow web and ssh traffic"
  vpc_id      = "vpc-007ead90ae7468f2e"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "public_sg"
  }
}


resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Allow web tier and ssh traffic"
  vpc_id      = "vpc-007ead90ae7468f2e"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
    security_groups = [aws_security_group.public_sg.id]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "private_sg"
  }
}


# Security group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "security group for alb"
  vpc_id      = "vpc-007ead90ae7468f2e"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Create ALB
resource "aws_lb" "project_alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

# Create ALB target group
resource "aws_lb_target_group" "project_tg" {
  name     = "project-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-007ead90ae7468f2e"
  
  health_check {
    interval            = 70
    path                = "/"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}
# Create target attachments
resource "aws_lb_target_group_attachment" "tg_attach1" {
  target_group_arn = aws_lb_target_group.project_tg.arn
  target_id        = aws_instance.web1.id
  port             = 80

  depends_on = [aws_instance.web1]
}

resource "aws_lb_target_group_attachment" "tg_attach2" {
  target_group_arn = aws_lb_target_group.project_tg.arn
  target_id        = aws_instance.web2.id
  port             = 80

  depends_on = [aws_instance.web2]
}

# Create listener
resource "aws_lb_listener" "listener_lb" {
  load_balancer_arn = aws_lb.project_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project_tg.arn
  }
}

#  Create ec2 instances
resource "aws_instance" "web1" {
  ami                         = "ami-0b0dcb5067f052a63"
  instance_type               = "t2.micro"
  key_name                    = "WebServerKey"
  availability_zone           = "us-east-1a"
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  subnet_id                   = aws_subnet.public_1.id
  associate_public_ip_address = true
  user_data                   = <<-EOF
        #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start 
        systemctl enable
        echo '<h1>Just Keep Swimming</h1>' > /usr/share/nginx/html/index.html
        EOF

  tags = {
    Name = "web1_instance"
  }
}
resource "aws_instance" "web2" {
  ami                         = "ami-0b0dcb5067f052a63"
  instance_type               = "t2.micro"
  key_name                    = "WebServerKey"
  availability_zone           = "us-east-1b"
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  subnet_id                   = aws_subnet.public_2.id
  associate_public_ip_address = true
  user_data                   = <<-EOF
        #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start 
        systemctl enable
        echo '<h1>Beyonce has the same 24</h1>' > /usr/share/nginx/html/index.html
        EOF

  tags = {
    Name = "web2_instance"
  }
}

# Database subnet group
resource "aws_db_subnet_group" "db_subnetgroup" {
  name       = "db_subnetgroup"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

# Create database instance
resource "aws_db_instance" "project_db" {
  allocated_storage           = 5
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "db.t2.micro"
  identifier                  = "db-instance"
  db_name                     = "project_db"
  username                    = "admin"
  password                    = "password"
  db_subnet_group_name        = "db_subnetgroup"
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  backup_retention_period     = 35
  backup_window               = "22:00-23:00"
  maintenance_window          = "Sat:00:00-Sat:03:00"
  multi_az                    = false
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  publicly_accessible         = false
  skip_final_snapshot         = true
}















