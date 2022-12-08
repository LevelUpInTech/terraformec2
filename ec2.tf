module "ec2_instance" {
  source = "./instance_module/"

  instance_name = var.instance_name
  ami           = var.ami
  instance_type = var.instance_type

}
