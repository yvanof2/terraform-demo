resource "aws_lb" "this" {
  name               = "demo-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.subnet_id]        # 1 AZ
  security_groups    = [var.security_group_id]
}

resource "aws_lb_target_group" "this" {
  name   = "demo-tg"
  port   = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
