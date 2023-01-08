# Child module
# ec2-deployment/ec2.tf

resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance

  tags = {
    Name = "JC-App-Server-Instance"
  }
}