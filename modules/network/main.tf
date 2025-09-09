# VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.az
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.az
}

# RDS Security Group
resource "aws_security_group" "rds" {
  name        = "rds_sg"
  description = "Security group for RDS"
  vpc_id      = aws_vpc.this.id

  # Allow MySQL traffic from EC2 instances in the VPC
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
