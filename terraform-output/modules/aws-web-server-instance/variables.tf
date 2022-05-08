variable "ec2_instance_name" {
  description = "Name for web server EC2 instance"
  type    = string
  default = "web_server"
}

variable "ec2_instance_type" {
  description = "Instance type for web server EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ec2_security_group_name" {
  description = "Security group name for web server EC2 instance"
  type    = string
  default = "web_server"

}

variable "ec2_security_group_description" {
  description = "Security group description for web server EC2 instance"
  type    = string
  default = "Allow traffic for webserver"
}

variable "vpc_id" {
  description = "VPC id for web server EC2 instance"
  type = string
}

variable "subnet_id" {
  description = "Subnet id for web server EC2 instance"
  type = string
}
