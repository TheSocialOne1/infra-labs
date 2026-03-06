#############################################
# Terraform + AWS Provider
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
  region = var.aws_region
}

#############################################
# Data Source: Availability Zones
#############################################

# Ask AWS which availability zones exist in this region
data "aws_availability_zones" "available" {}

#############################################
# VPC
#############################################

resource "aws_vpc" "lab_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "ec2-lab-vpc"
  }
}

#############################################
# Public Subnet
#############################################

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "ec2-lab-public-subnet"
  }
}

#############################################
# Internet Gateway
#############################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name = "ec2-lab-igw"
  }
}

#############################################
# Public Route Table
#############################################

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "ec2-lab-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

#############################################
# Security Group
#############################################

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-lab-sg"
  description = "Allow SSH from my IP and HTTP from anywhere"
  vpc_id      = aws_vpc.lab_vpc.id

  # SSH only from your laptop IP
  ingress {
    description = "SSH from my IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  # HTTP from anywhere
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-lab-sg"
  }
}

#############################################
# Data Source: Amazon Linux 2023 AMI
#############################################

# This asks AWS for the most recent Amazon Linux 2023 AMI.
# We use a data source here so we do NOT hardcode an AMI ID.
# Hardcoding AMI IDs is bad practice because AMIs change over time.
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#############################################
# EC2 Instance
#############################################

# This creates a small EC2 instance in the public subnet.
# IMPORTANT:
# We are only going to PLAN this for now, not apply it.
resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "ec2-lab-web-server"
  }
}


