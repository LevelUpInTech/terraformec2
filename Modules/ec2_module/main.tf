#-----root_ec2/main.tf-----
resource "aws_instance" "EC2appserver" {
  ami           = var.ami_id
  instance_type = var.instance
  # vpc_security_group_ids = ["HTTP_allow"]
  key_name  = data.aws_key_pair.TFprojectkp.key_name
  user_data = var.user_data


  tags = {
    Name = "EC2appserver"
  }
}

resource "aws_key_pair" "TFprojectkp" {
  key_name   = "TFprojectkp"
  public_key = tls_private_key.pvt_key.public_key_openssh
}

module "security" {
  source = "./Modules/security"
}
