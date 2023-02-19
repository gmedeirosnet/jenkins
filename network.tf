resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "jenkins_vpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "jenkins_subnet"
  }
}

resource "aws_internet_gateway" "jenkins_igw" {
  vpc_id = aws_vpc.vpc.id

    tags = {
    Name = "jenkins_igw"
  }
}

resource "aws_route_table" "jenkins_route_table" {
  vpc_id = aws_vpc.vpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins_igw.id
  }

    tags = {
    Name = "jenkins_route-table"
  }
}

resource "aws_route" "route" {
  route_table_id            = aws_route_table.jenkins_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.jenkins_igw.id
}

resource "aws_route_table_association" "jenkins_subnet" {
  subnet_id = aws_subnet.subnet.id
  route_table_id = aws_route_table.jenkins_route_table.id
}

resource "aws_network_interface" "eni" {
  private_ips = ["10.0.0.50"]
  subnet_id   = aws_subnet.subnet.id
  security_groups = [aws_security_group.jenkins_sg.id]

      tags = {
    Name = "jenkins_eni"
  }
}

resource "aws_eip" "eip" {
  instance = aws_instance.jenkins.id
  vpc      = true

    tags = {
    Name = "jenkins_eip"
  }
}