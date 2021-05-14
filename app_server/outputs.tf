# Output variable definitions

output "arn" {
  description = "ARN of the server"
  value       = aws_instance.app_server.arn
}

output "server_name" {
  description = "Name (id) of the sever"
  value       = aws_instance.app_server.id
}
