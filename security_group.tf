# Create a Security Group to communicate to servers in DMZ
resource "aws_security_group" "xx-sec_group_dmz" {
  name        = "${var.PROJECT}-dmz"
  description = "Allow SSH and HTTP(S) traffic"
  vpc_id      = aws_vpc.xx-vpc.id

  dynamic "ingress" {
    iterator = port
    for_each = var.SECURITY_GROUP["dmz"]["ports"]
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = var.SECURITY_GROUP["dmz"]["protocol"]
      cidr_blocks = var.SECURITY_GROUP["dmz"]["cidr_block"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Entity    = "sec_group"
    Lifecycle = terraform.workspace
    Name      = "${var.PROJECT}-dmz"
    Project   = var.PROJECT
  }

}

# Create a Security Group to communicate to servers in Web Layer
resource "aws_security_group" "xx-sec_group_web" {
  name        = "${var.PROJECT}-web"
  description = "Allow SSH and HTTP(S) traffic"
  vpc_id      = aws_vpc.xx-vpc.id

  dynamic "ingress" {
    iterator = port
    for_each = var.SECURITY_GROUP["web"]["ports"]
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = var.SECURITY_GROUP["web"]["protocol"]
      cidr_blocks = var.SECURITY_GROUP["web"]["cidr_block"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Entity    = "sec_group"
    Lifecycle = terraform.workspace
    Name      = "${var.PROJECT}-web"
    Project   = var.PROJECT
  }

}
