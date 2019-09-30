# bastion hosts in the public / DMZ subnet
# currently used to demonstrate ansible playbook execution
resource "aws_instance" "xx-instance-bastion" {
  count           = 2
  ami             = var.AMI[var.AWS_REGION]
  instance_type   = var.INSTANCE_TYPE
  #subnet_id       = tolist(data.aws_subnet_ids.xx-subnet-dmz.ids)[count.index]
  subnet_id       = aws_subnet.xx-subnet-dmz.*.id[count.index]
  security_groups = [aws_security_group.xx-sec_group_dmz.id]
  key_name        = var.KEY_NAME

  tags = {
    Entity    = "ec2"
    Project   = var.PROJECT
    Name      = "${var.PROJECT}-bastion-${count.index}"
    Lifecycle = terraform.workspace
  }

  provisioner "local-exec" {
    #command = "echo ${aws_instance.xx-instance[count.index].public_ip} >> /tmp/httpd.txt"
    command = "echo ${self.public_ip} >> /tmp/httpd.txt"
  }

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -v -u ec2-user --private-key=/users/arunp/.ssh/apn-key httpd.yml -i /tmp/httpd.txt"
  }

}
