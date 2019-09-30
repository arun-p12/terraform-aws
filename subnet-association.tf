# Associate Subnet to the Route Table (DMZ)
resource "aws_route_table_association" "xx-rt-internet" {
  count = length(aws_subnet.xx-subnet-dmz)
  subnet_id = aws_subnet.xx-subnet-dmz.*.id[count.index]
  route_table_id = aws_route_table.xx-route-internet.id
}

# Associate Subnet to the Route Table (Web)
resource "aws_route_table_association" "xx-rt-internet2" {
  count = length(aws_subnet.xx-subnet-web)
  subnet_id = aws_subnet.xx-subnet-web.*.id[count.index]
  route_table_id = aws_route_table.xx-route-internet.id
}
