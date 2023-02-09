resource "aws_instance" "my_server" {
  ami           = var.ami_in
  instance_type = var.instance_type_in

  tags = {
    Name = var.name_in
  }
  vpc_security_group_ids = var.sg_group_in
}