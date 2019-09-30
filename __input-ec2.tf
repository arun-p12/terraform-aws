# Image ID that corresponds to the choice of instance type
variable "AMI" {
  default = {
    "us-east-1" = "ami-0b69ea66ff7391e80"
    "us-east-2" = "ami-00c03f7f7f2ec15c3"
    "us-west-1" = "ami-0245d318c6788de52"
    "us-west-2" = "ami-04b762b4289fba92b"
  }
}

# current set to the free tier.
variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

# key-pair to connect/ssh into the instance
variable "KEY_NAME" {
  default = "apn-key"
}
