resource "aws_db_instance" "this" {
  db_name              = var.db_name          # Use db_name instead of name
  username             = var.username
  password             = var.password
  instance_class       = var.instance_type
  allocated_storage    = 20
  engine               = "mysql"
  skip_final_snapshot  = true
  publicly_accessible  = false

  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name   = var.subnet_id
}

