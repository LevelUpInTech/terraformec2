#------SGModule/main.tf-------
#--Security group that will allow all traffic to webservers on port 80 & ssh from our IP:
resource "aws_security_group" "HTTP_allow" {
  name        = "HTTP_allow"
  description = "Enable HTTP and SSH access to ec2 instances"


  #Allow SSH access.
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow incoming HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Allow outgoing--access to web.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}