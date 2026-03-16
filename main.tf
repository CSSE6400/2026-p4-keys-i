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

resource "aws_instance" "hextris-server" {
   ami = "ami-0c421724a94bba6d6"
   instance_type = "t2.micro"
   key_name = "vockey"
   security_groups = [aws_security_group.hextris-server.name]
  user_data = file("./serve-hextris.sh")

   tags = {
      Name = "hextris"
   }
}

output "hextris-url" {
 value = aws_instance.hextris-server.public_ip
}
