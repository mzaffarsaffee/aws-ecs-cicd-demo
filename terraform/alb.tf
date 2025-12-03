resource "aws_lb" "main" {
  name               = "demo-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
}

# Target Group BLUE (Primary)
resource "aws_lb_target_group" "blue" {
  name        = "demo-tg-blue"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_default_vpc.default.id

  health_check {
    path = "/health"
    port = 3000
  }
}

# Target Group GREEN (For new deployments)
resource "aws_lb_target_group" "green" {
  name        = "demo-tg-green"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_default_vpc.default.id

  health_check {
    path = "/health"
    port = 3000
  }
}

# Listener (Directs traffic to Blue by default)
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}