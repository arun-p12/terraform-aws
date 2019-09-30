# the more updated launch template (replaces launch configuration)
resource "aws_launch_template" "xx-launch-template" {
  name_prefix     = "${var.PROJECT}t-"
  image_id        = var.AMI[var.AWS_REGION]
  instance_type   = var.INSTANCE_TYPE
  key_name        = var.KEY_NAME
  vpc_security_group_ids = [aws_security_group.xx-sec_group_web.id]
  user_data       = base64encode(file("httpd.txt"))
}
