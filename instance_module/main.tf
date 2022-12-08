resource "aws_instance" "ec2" {

  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}