#-----root/main.tf-----

resource "aws_instance" "ec2module" {
  ami           = var.ami_id
  instance_type = var.instance

  tags = {
    Name = "EC2appserver"
  }
}

# module "security" {
#   source = "./Modules/security"
# }
