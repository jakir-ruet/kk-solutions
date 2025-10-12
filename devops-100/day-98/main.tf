provider "aws" {
  region = "us-east-1"
}

# --------------------------
# VPC Creation
# --------------------------
resource "aws_vpc" "nautilus_priv_vpc" {
  cidr_block           = var.KKE_VPC_CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "nautilus-priv-vpc"
  }
}

# --------------------------
# Subnet Creation
# --------------------------
resource "aws_subnet" "nautilus_priv_subnet" {
  vpc_id                  = aws_vpc.nautilus_priv_vpc.id
  cidr_block              = var.KKE_SUBNET_CIDR
  map_public_ip_on_launch = false

  tags = {
    Name = "nautilus-priv-subnet"
  }
}

# --------------------------
# Security Group (VPC Internal Access Only)
# --------------------------
resource "aws_security_group" "nautilus_priv_sg" {
  name        = "nautilus-priv-sg"
  description = "Allow traffic only within VPC"
  vpc_id      = aws_vpc.nautilus_priv_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.KKE_VPC_CIDR]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.KKE_VPC_CIDR]
  }

  tags = {
    Name = "nautilus-priv-sg"
  }
}

# --------------------------
# EC2 Instance
# --------------------------
resource "aws_instance" "nautilus_priv_ec2" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 in us-east-1 (update if needed)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.nautilus_priv_subnet.id
  vpc_security_group_ids = [aws_security_group.nautilus_priv_sg.id]

  tags = {
    Name = "nautilus-priv-ec2"
  }
}
