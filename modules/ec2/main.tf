resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [var.security_group_id]

  user_data = var.user_data

  tags = {
    Name = "Demo-EC2"
  }
}

# Output EC2 instance ID
# EC2 Security Group
resource "aws_security_group" "ec2" {
  name        = "ec2_sg"
  description = "Security group for EC2 instance"
  vpc_id      = var.vpc_id  # Pass vpc_id from module input

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
