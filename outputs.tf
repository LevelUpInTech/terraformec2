#---root/outputs.tf

output "public_ip" {
  value = aws_instance.db_server.public_ip
}

output "ec2_tags" {
  value = aws_instance.db_server.tags_all.Name
}