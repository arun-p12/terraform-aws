# Create Route Table for Internet Access
resource "aws_route_table" "xx-route-internet" {
  vpc_id = aws_vpc.xx-vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.xx-internet-gw.id
  }
  tags = {
    Entity    = "route"
    Lifecycle = terraform.workspace
    Name      = "${var.PROJECT}-internet"
    Project   = var.PROJECT
  }
}
