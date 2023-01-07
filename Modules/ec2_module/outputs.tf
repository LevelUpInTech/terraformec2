#-----ec2module/outputs.tf-----
output "public_ip" {
  value = aws_instance.EC2appserver[*].public_ip
}

output "ec2_tags" {
  value = aws_instance.EC2appserver[*].tags_all.Name
}



