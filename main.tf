#---root/main.tf

resource "aws_instance" "db_server" {
  ami           = "ami-033cfb3e88287e319"
  instance_type = "t2.micro"

  tags = {
    Name = "db_tag"
  }
}
