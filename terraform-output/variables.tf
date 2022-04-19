variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "ec2_instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
  default     = "t2.small"
}