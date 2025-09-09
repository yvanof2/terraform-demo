provider "aws" {
  region = var.aws_region
}

# ----------------------
# Network Module
# ----------------------
module "network" {
  source   = "./modules/network"
  vpc_cidr = "10.0.0.0/16"
  az       = var.az
}

# ----------------------

# EC2 Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Security group for EC2"
  vpc_id      = module.network.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["73.128.24.153/32"]  # Optional: restrict SSH
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ----------------------
# EC2 Module
# ----------------------
module "ec2" {
  source            = "./modules/ec2"
  ami               = var.ec2_ami
  instance_type     = var.ec2_instance_type
  subnet_id         = module.network.public_subnet_id
  vpc_id            = module.network.vpc_id
  security_group_id = aws_security_group.ec2_sg.id  # <- Add this

  user_data = <<-EOF
              #!/bin/bash
              echo "Welcome to Bido's demo" > /var/www/html/index.html
              EOF
}


# ----------------------
# RDS Module
# ----------------------
module "rds" {
  source            = "./modules/rds"
  db_name           = "mydb"
  username          = "admin"
  password          = "changeme123"
  instance_type     = "db.t3.micro"
  subnet_ids        = [aws_subnet.demo1.id, aws_subnet.demo2.id] # <-- needs at least 2 subnets in different AZs
  security_group_id = aws_security_group.rds_sg.id
}


# ----------------------
# ALB Module
# ----------------------
module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.network.vpc_id
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.ec2.ec2_sg_id
  instance_ids      = [module.ec2.instance_id]   # single-element list
}
resource "aws_subnet" "rds_az1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"   # adjust to your region
}

resource "aws_subnet" "rds_az2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"   # adjust to your region
}
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow MySQL traffic from EC2"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block] # allow VPC internal traffic
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


