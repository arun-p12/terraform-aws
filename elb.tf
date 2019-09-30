resource "aws_elb" "xx-elb" {
  name               = "${var.PROJECT}-clb"
  security_groups    = [aws_security_group.xx-sec_group_web.id]
  #subnets            = tolist(data.aws_subnet_ids.xx-subnet-web.ids)
  subnets            = aws_subnet.xx-subnet-web.*.id

  health_check {
    target              = "HTTP:${var.SERVICE_PORT}/"
    interval            = 30
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  # This adds a listener for incoming HTTP requests.
  listener {
    lb_port           = var.LB_PORT
    lb_protocol       = "http"
    instance_port     = var.SERVICE_PORT
    instance_protocol = "http"
  }

  tags = {
    Entity    = "elb"
    Project   = var.PROJECT
    Name      = "${var.PROJECT}-clb"
    Lifecycle = terraform.workspace
  }
}
