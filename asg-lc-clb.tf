resource "aws_autoscaling_group" "xx-asg" {
  name                 = "${var.PROJECT}-asg-clb"
  launch_configuration = aws_launch_configuration.xx-launch-conf.id

  # list of subnets into which the instances can be instantiated
  vpc_zone_identifier  = aws_subnet.xx-subnet-web.*.id

  min_size = var.MIN_INSTANCES
  max_size = var.MAX_INSTANCES

  # load balancer = classic load balancer
  load_balancers    = [aws_elb.xx-elb.name]
  health_check_type = var.HEALTH_CHECK_TYPE

  tag {
    key   = "Name"
    value = "${var.PROJECT}-web-lc"
    propagate_at_launch = true
  }
}
