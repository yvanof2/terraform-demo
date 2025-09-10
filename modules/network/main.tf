# VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
}

# Public Subnet in AZ1
resource "aws_subnet" "public_az1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.az1
}

# Public Subnet in AZ2
resource "aws_subnet" "public_az2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.az2
}

# Private Subnet in AZ1 (optional, for RDS/EC2)
resource "aws_subnet" "private_az1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.az1
}

# Private Subnet in AZ2 (optional)
resource "aws_subnet" "private_az2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.az2
}

# RDS Security Group
resource "aws_security_group" "rds" {
  name        = "rds_sg"
  description = "Security group for RDS"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Output subnet IDs for use in ALB and other modules

