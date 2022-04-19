variable "vpc_cidr_block" {
  description = "CIDR block for webserer VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "web_server_vpc"
}

variable "subnet_cidr_block" {
  type    = string
  default = "10.0.0.0/24"
}

variable "subnet_name" {
  type    = string
  default = "web_server_subnet"
}

variable "aws_az" {
  type    = string
  default = "us-east-1a"
}

variable "igw_name" {
  type    = string
  default = "web_server_igw"
}

variable "rt_name" {
  type    = string
  default = "web_server_rt"
}
