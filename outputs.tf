output "public_ip" {
   value = aws_instance.app_server[*].public_ip
}   

output "instance" {
   value = var.ami_id
   description = "ID of the EC2 instance"
}
