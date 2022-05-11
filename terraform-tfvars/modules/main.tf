//referencing ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent      = true
  owners           = ["099720109477"] #Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

//spinning up another billing server
resource "aws_instance" "billing_server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  tags = {
    "service" = "billing"
  }
}