# Output variable definitions

output "arn" {
  description = "ARN of the server"
  value       = aws_instance.app_server.arn
}

output "name" {
  description = "Name (id) of the sever"
  value       = aws_instance.app_server.id
}
