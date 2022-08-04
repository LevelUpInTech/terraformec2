#---ec2-instance/main.tf---

resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "ExampleAppServerInstance"
  }
}