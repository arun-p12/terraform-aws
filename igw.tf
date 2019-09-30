# Create an Internet Gateway
resource "aws_internet_gateway" "xx-internet-gw" {
  vpc_id = "${aws_vpc.xx-vpc.id}"
  tags   = {
    Entity    = "igw"
    Lifecycle = terraform.workspace
    Name      = var.PROJECT
    Project   = var.PROJECT
  }
}
