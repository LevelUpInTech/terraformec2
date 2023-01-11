#--- module-ec2/outputs.tf

output "public_ip" {
  value = aws_instance.my_app_server.public_ip
  description = "Gives the public ip address of the created ec2 instance"
}