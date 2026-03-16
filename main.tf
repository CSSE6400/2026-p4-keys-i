terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["./credentials"]
  default_tags {
    tags = {
        Environment = "Dev"
        Course = "CSSE6400"
        StudentID = "49088276"
    }
  }
}

# -- security group --
resource "aws_security_group" "hextris-server" {
 name = "hextris-server"
 description = "Hextris HTTP and SSH access"

 ingress {
   from_port = 80
   to_port = 80
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

 ingress {
   from_port = 22
   to_port = 22
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

# EC2 instance
resource "aws_instance" "hextris-server" {
   ami = "ami-0c421724a94bba6d6"
   instance_type = "t2.micro"
   key_name = "vockey"
   security_groups = [aws_security_group.hextris-server.name]
   user_data = <<-EOF
   #!/bin/bash
   yum install -y httpd
   systemctl enable httpd
   systemctl start httpd

   yum install -y git
   cd /var/www/html
   git clone https://github.com/Hextris/hextris .
   EOF

   tags = {
      Name = "hextris"
   }
}

data "aws_ami" "latest" {
 most_recent = true
 owners = ["amazon"]

 filter {
   name = "name"
   values = ["al2023-ami-2023*"]
 }

 filter {
   name = "root-device-type"
   values = ["ebs"]
 }

 filter {
   name = "virtualization-type"
   values = ["hvm"]
 }

 filter {
   name = "architecture"
   values = ["x86_64"]
 }
}

# output
output "hextris-url" {
 value = aws_instance.hextris-server.public_ip
}
