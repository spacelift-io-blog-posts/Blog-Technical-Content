output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.web_server.id
}

output "subnet_id" {
  description = "ID of the VPC subnet"
  value       = aws_subnet.web_server.id
}