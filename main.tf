module "ec2_instance" {
  source           = "./ec2"
  ami_in           = var.ami_in
  instance_type_in = var.instance_type_in
  name_in          = var.name_in
  sg_group_in      = [module.sg.sg_id]
}

module "sg" {
  source  = "./sg"
  name_in = "my_sg"
}