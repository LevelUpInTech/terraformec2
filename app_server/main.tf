
provider "aws" {
  region = var.region
}

module "ec2" {
  source = "../.."

}
resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  tags = {
    Name = var.server_name
  }
}

