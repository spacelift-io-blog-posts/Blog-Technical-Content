output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.web_server_vpc.id
}

output "subnet_id" {
  description = "IDs of the VPC subnet"
  value       = aws_subnet.web_server_subnet.id
}