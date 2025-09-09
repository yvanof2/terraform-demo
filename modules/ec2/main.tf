resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  user_data = var.user_data

  tags = {
    Name = "DemoEC2"
  }
}
