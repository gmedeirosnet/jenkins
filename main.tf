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

resource "aws_route53_record" "laboratory" {
  zone_id = "ZJBMBQ4H64DAE"
  name = "laboratory.gmedeiros.net"
  type = "CNAME"
  ttl = "300"
  records = [aws_instance.laboratory.public_dns]
}

resource "aws_instance" "laboratory" {
  ami           = "ami-0568936c8d2b91c4e"
  instance_type = "t3.large"
  key_name      = "Laboratory"
  network_interface {
    network_interface_id = aws_network_interface.eni.id
    device_index = 0 
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = 16
  }

  tags = {
    Name = "laboratory"
  }
}

resource "aws_key_pair" "laboratory_key" {
  key_name   = "Laboratory"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCDk9fIBraD7ERZZDO+2Ja1wYd4GnH8ixZTpYboblE+/x4FZK7ZlRgQbORfGenthY/Eth10hYwaTaqEBIGt3387HjObu5EtaFIIG8N2qr12VOPZPr1DdCGkJlndFgZDERWxJlveilOx7bFgyQjVJ8UM80bQMsal8uWnIPruBuSyqfqwkXCXBeO2sw4e0MEwYcK8RimoQqEO8sRh94Y0BzzJe67jXOtljqHBJm0BgpCKDaU/oFWlHT/VSvjkA/2uNohtF22xmMLDtASsxEbmJ6q9BlEtjsv4dCQD1DHn54/uwfBZ+8n/PmUJ3BeMqJ3Rd9HktalySrgn5MfqmjtfdAhT imported-openssh-key"
  }