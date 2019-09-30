# the older style launch configuration
resource "aws_launch_configuration" "xx-launch-conf" {
  name_prefix     = "${var.PROJECT}c-"
  image_id        = var.AMI[var.AWS_REGION]
  instance_type   = var.INSTANCE_TYPE
  security_groups = [aws_security_group.xx-sec_group_web.id]
  user_data       = file("nginx.txt")

  lifecycle {
    create_before_destroy = true
  }
}
