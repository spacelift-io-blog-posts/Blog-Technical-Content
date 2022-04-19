variable "ec2_instance_name" {
  type    = string
  default = "web_server_instance"
}

variable "ec2_instance_type" {
  description = "Instance type for web server EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ec2_security_group_name" {
  type    = string
  default = "web_server_sc"

}

variable "ec2_security_group_description" {
  type    = string
  default = "Allow traffic for webserver"
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}