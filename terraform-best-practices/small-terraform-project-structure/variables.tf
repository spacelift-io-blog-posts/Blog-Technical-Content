variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "Default value for VPC CIDR"
  type        = string
  default     = "172.31.0.0/16"
}

variable "instance_tenancy" {
  description = "Tenancy for ec2 instances"
  type        = string
  default     = "default"
}