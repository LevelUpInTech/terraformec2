provider "aws" {
  region = var.region
}

module "ec2" {
  source = "../.."

}

variable "server_name" {
  default = ""
}

variable "region" {
  default = ""
}
resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  tags = {
    Name = var.server_name
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }
}
