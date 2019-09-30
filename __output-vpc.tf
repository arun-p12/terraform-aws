# ID of the VPC created
output "vpc-id" {
  value = aws_vpc.xx-vpc.id
}

output "security_group_dmz_id" {
  value = aws_security_group.xx-sec_group_dmz.id
}

output "security_group_web_id" {
  value = aws_security_group.xx-sec_group_web.id
}

output "route_table_internet" {
  value = aws_route_table.xx-route-internet.id
}
