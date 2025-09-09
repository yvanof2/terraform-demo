# ----------------------
# ALB
# ----------------------
resource "aws_lb" "this" {
  name               = "demo-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.subnet_id]   # only 1 subnet since 1AZ
}

resource "aws_lb_target_group" "this" {
  name     = "demo-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Single instance attachment
resource "aws_lb_target_group_attachment" "this" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.instance_ids[0]   # first EC2 instance
  port             = 80
}

# ----------------------
# Outputs
# ----------------------
output "alb_dns_name" {
  value = aws_lb.this.dns_name
}
