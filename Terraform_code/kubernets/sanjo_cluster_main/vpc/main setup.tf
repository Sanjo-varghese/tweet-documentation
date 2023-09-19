provider "aws" {
  region  = "us-east-2"
}

#resource "aws_instance" "sanjo-server" {
#   ami = "ami-024e6efaf93d85776"
#    instance_type = "t2.micro"
#    key_name = "sanjo"
#   //security_groups = [ "sanjo-sg" ]
#    vpc_security_group_ids = [aws_security_group.sanjo-sg.id]
#    subnet_id = aws_subnet.sanjo-public-subnet-01.id 
#for_each = toset(["jenkins-master", "build-slave", "ansible"])
#  tags = {
#   Name = "${each.key}"
#   }
#}

resource "aws_security_group" "sanjo-sg" {
  name        = "sanjo-sg"
  description = "SSH Access"
  vpc_id = aws_vpc.sanjo-vpc.id 
  
# ingress {
#  description      = "SHH access"
#    from_port        = 22
#   to_port          = 22
#    protocol         = "tcp"
#   cidr_blocks      = ["0.0.0.0/0"]
#    }

#   ingress {
#   description      = "Jenkins port"
#    from_port        = 8080
#    to_port          = 8080
#    protocol         = "tcp"
#   cidr_blocks      = ["0.0.0.0/0"]
#   }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ssh-prot"

  }
}

resource "aws_vpc" "sanjo-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "sanjo-vpc"
  }
  
}

resource "aws_subnet" "sanjo-public-subnet-01" {
  vpc_id = aws_vpc.sanjo-vpc.id
 cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
 availability_zone = "us-east-2a"
 tags = {
   Name = "sanjo-public-subent-01"
  }
}

resource "aws_subnet" "sanjo-public-subnet-02" {
  vpc_id = aws_vpc.sanjo-vpc.id
  cidr_block = "10.1.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2b"
  tags = {
    Name = "sanjo-public-subent-02"
  }
}

resource "aws_internet_gateway" "sanjo-igw" {
  vpc_id = aws_vpc.sanjo-vpc.id 
  tags = {
    Name = "sanjo-igw"
  } 
}

resource "aws_route_table" "sanjo-public-rt" {
  vpc_id = aws_vpc.sanjo-vpc.id 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sanjo-igw.id 
  }
}

resource "aws_route_table_association" "sanjo-rta-public-subnet-01" {
  subnet_id = aws_subnet.sanjo-public-subnet-01.id
  route_table_id = aws_route_table.sanjo-public-rt.id   
}

resource "aws_route_table_association" "sanjo-rta-public-subnet-02" {
  subnet_id = aws_subnet.sanjo-public-subnet-02.id 
  route_table_id = aws_route_table.sanjo-public-rt.id   
}

module "sgs" {
    source = "../sg_eks"
    vpc_id     =     aws_vpc.sanjo-vpc.id
  }

  module "eks" {
      source = "../eks"
       vpc_id     =     aws_vpc.sanjo-vpc.id
       subnet_ids = [aws_subnet.sanjo-public-subnet-01.id,aws_subnet.sanjo-public-subnet-02.id]
      sg_ids = module.sgs.security_group_public
  }