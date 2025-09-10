provider "aws" {
  region = var.aws_region
}

# ----------------------
# Network Module
# ----------------------
module "network" {
  source   = "./modules/network"
  vpc_cidr = "10.0.0.0/16"
  az1      = var.azs[0]
  az2      = var.azs[1]
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
    from_port_
