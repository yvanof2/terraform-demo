provider "aws" {
  region = var.aws_region
}

# --- Network module ---
module "network" {
  source  = "./modules/network"
  vpc_cidr = "10.0.0.0/16"
  az       = var.az
}

# --- EC2 module ---
module "ec2" {
  source           = "./modules/ec2"
  vpc_id           = module.network.vpc_id
  subnet_id        = module.network.public_subnet_id
  instance_type    = var.ec2_instance_type
  ami              = var.ec2_ami
  user_data        = <<-EOF
                      #!/bin/bash
                      echo "Welcome to Bido's demo" > /var/www/html/index.html
                      EOF
}

# --- ALB module ---
module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.network.vpc_id
  subnet_id      = module.network.public_subnet_id
  target_group   = [module.ec2.instance_id]
}

# --- RDS module ---
module "rds" {
  source       = "./modules/rds"
  subnet_id    = module.network.private_subnet_id
  db_name      = var.db_name
  username     = var.db_username
  password     = var.db_password
  instance_type = var.db_instance_type
}

# --- Outputs ---
output "alb_url" {
  value = module.alb.alb_dns_name
}
