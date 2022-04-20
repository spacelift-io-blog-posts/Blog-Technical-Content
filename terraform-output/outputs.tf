output "vpc_id" {
  description = " ID of the vpc"
  value       = module.aws_web_server_vpc.vpc_id
}

output "instance_id" {
  description = "IDs of EC2 instance"
  value       = module.aws_web_server_instance.instance_id
}

output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = module.aws_web_server_instance.instance_public_ip
}