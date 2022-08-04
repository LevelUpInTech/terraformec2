#---ec2-instance/outputs.tf---

output "ec2_tags" {
    value = aws_instance.app_server.tags_all.Name
}

output "public_ip" {
    value = aws_instance.app_server.public_ip
}