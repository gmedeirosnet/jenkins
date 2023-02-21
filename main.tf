terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 4.7"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

variable availability_zone_01 {
  default = "us-east-2a"
}

resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins"
  public_key = ""
  }

resource "aws_instance" "jenkins" {
  ami           = "ami-0568936c8d2b91c4e"
  instance_type = "t3.large"
  key_name      = "jenkins"
  network_interface {
    network_interface_id = aws_network_interface.eni.id
    device_index = 0 
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = 16
  }

  tags = {
    Name = "jenkins"
  }
}

  resource "aws_route53_record" "jenkins" {
  depends_on = [
    aws_instance.jenkins,
    aws_eip.eip,
  ]
  zone_id = "ZJBMBQ4H64DAE"
  name = "jenkins.gmedeiros.net"
  type = "CNAME"
  ttl = "300"
  records = [aws_instance.jenkins.public_dns]
}
