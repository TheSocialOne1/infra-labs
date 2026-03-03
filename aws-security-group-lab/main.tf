#############################################
# Provider Setup (Level 1 - minimal)
#############################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

#############################################
# VPC (simple, same as prior lab)
#############################################

resource "aws_vpc" "lab_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "lab-web-admin"
  }
}

#############################################
# Public subnet + IGW + routing (so later EC2 can be tested)
#############################################

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "sg-lab-public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name = "sg-lab-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.lab_vpc.id

  # Default route: send internet-bound traffic to the IGW
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "sg-lab-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

#############################################
# Security Group (the focus of this lab)
#############################################

resource "aws_security_group" "web_admin_sg" {
  name        = "lab-web-admin"
  description = "Allow HTTPS from anywhere, SSH only from my IP"
  vpc_id      = aws_vpc.lab_vpc.id

  # Inbound rule: SSH only from YOUR current public IP
  ingress {
    description = "SSH from my IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["107.190.254.120/32"]
  }

  # Inbound rule: HTTPS from anywhere (common for web endpoints)
  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound: allow all (default typical behavior)
  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab-web-admin"
  }
}
