# application load balancer
resource "aws_lb" "xx-lb" {
  name               = "${var.PROJECT}-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.xx-sec_group_web.id]
  #subnets            = tolist(data.aws_subnet_ids.xx-subnet-web.ids)
  subnets            = aws_subnet.xx-subnet-web.*.id
  enable_http2       = true

  tags = {
    Entity    = "elb"
    Project   = var.PROJECT
    Name      = "${var.PROJECT}-alb"
    Lifecycle = terraform.workspace
  }
}

# configure the listener for the load balancer
resource "aws_lb_listener" "xx-lb-listener" {
  load_balancer_arn = aws_lb.xx-lb.arn
  port           = var.LB_PORT
  protocol       = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.xx-lb-target.arn}"
  }
}

# the routing rules for the load balancer
resource "aws_alb_listener_rule" "xx-lb-rule" {
  #depends_on   = ["aws_alb_target_group.xx-lb-target"]
  listener_arn = "${aws_lb_listener.xx-lb-listener.arn}"

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.xx-lb-target.id}"
  }

  condition {
    field  = "path-pattern"
    values = ["/"]
  }
}

# the back-end / reals / targets behind the load balancer
resource "aws_lb_target_group" "xx-lb-target" {
  name_prefix = "${var.PROJECT}-"
  port        = var.SERVICE_PORT
  protocol    = "HTTP"
  vpc_id      = aws_vpc.xx-vpc.id

  tags = {
    Entity    = "lb-target"
    Project   = var.PROJECT
    Name      = "${var.PROJECT}-lbt"
    Lifecycle = terraform.workspace
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 1800
    enabled         = true
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/"
    port                = var.SERVICE_PORT
  }
}
