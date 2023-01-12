module "ec2_instance" {
    source = "./ec2_module"
    instance_type = "t2.micro"
    instance_count = 3
}