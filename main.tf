provider "aws" {
  region = var.aws_region
}

# ----------------------
# Network Module
# ----------------------
module "network" {
  source   = "./modules/network"
  vpc_cidr = "10.0.0.0/16"
  az1      = var.az1
  az2      = var.az2
}

# ----------------------
# EC2 Security Group
# ----------------------
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
    cidr_blocks = ["73.128.24.153/32"]  # Restrict SSH
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ----------------------
# RDS Security Group
# ----------------------
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow MySQL traffic from EC2"
  vpc_id      = module.network.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]  # Only EC2 SG can connect
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ----------------------
# ALB Security Group
# ----------------------
resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Allow HTTP/HTTPS traffic to ALB"
  vpc_id      = module.network.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
  subnet_id         = module.network.public_subnet_ids[0]
  vpc_id            = module.network.vpc_id
  security_group_id = aws_security_group.ec2_sg.id

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
  security_group_id = aws_security_group.rds_sg.id
  subnet_ids        = module.network.private_subnet_ids
}

# ----------------------
# ALB Module
# ----------------------
module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.network.vpc_id
  subnet_ids        = module.network.public_subnet_ids
  security_group_id = aws_security_group.alb_sg.id
  instance_ids      = [module.ec2.instance_id]
}
