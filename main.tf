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
# ----------------------
resource "aws_security_group" "ec2" {
  name   = "ec2_sg"
  vpc_id = module.network.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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
  subnet_id         = module.network.public_subnet_id
  security_group_id = aws_security_group.ec2.id
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
  subnet_id         = module.network.private_subnet_id
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password
  instance_type     = var.db_instance_type
  security_group_id = module.network.rds_sg_id
}

# ----------------------
# ALB Module
# ----------------------
module "alb" {
  source           = "./modules/alb"
  subnet_id        = module.network.public_subnet_id
  security_group_id = module.ec2.ec2_sg_id
  instance_ids     = [module.ec2.instance_id]
}

