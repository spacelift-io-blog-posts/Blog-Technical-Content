variable "vpc_cidr_block" {
  description = "CIDR block for webserver VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the vpc"
  type    = string
  default = "web_server"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the webserver subnet"
  type    = string
  default = "10.0.0.0/24"
}

variable "subnet_name" {
  description = "Name for the webserver subnet"
  type    = string
  default = "web_server"
}

variable "aws_az" {
  description = "Availability Zone for the webserver subnet"
  type    = string
  default = "us-east-1a"
}

variable "igw_name" {
  description = "Name for the Internet Gateway of the webserver vpc"
  type    = string
  default = "web_server"
}

variable "rt_name" {
  description = "Name for the route table of the webserver vpc"
  type    = string
  default = "web_server"
}
