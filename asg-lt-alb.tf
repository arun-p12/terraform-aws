resource "aws_autoscaling_group" "xx-asg2" {
  name                 = "${var.PROJECT}-asg-alb"

  #list of subnets into which the instances can be deployed
  vpc_zone_identifier  = aws_subnet.xx-subnet-web.*.id

  min_size = var.MIN_INSTANCES
  max_size = var.MAX_INSTANCES

  # load balancer = application load balancer
  target_group_arns = [aws_lb_target_group.xx-lb-target.id]
  health_check_type = var.HEALTH_CHECK_TYPE

  launch_template {
    id      = "${aws_launch_template.xx-launch-template.id}"
    version = "$Latest"
  }

  tag {
    key   = "Name"
    value = "${var.PROJECT}-web-lt"
    propagate_at_launch = true
  }
}
