output "instance_id" {
  description = "ID of EC2 instance"
  value       = aws_instance.web_server_instance.id
}

output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.web_server_instance.public_ip
}
