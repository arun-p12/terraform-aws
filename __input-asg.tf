variable "HEALTH_CHECK_TYPE" {
  default = "ELB"
}

# port at which the front-end service is exposed to consumers
variable "LB_PORT" {
  default = "80"
}

# minimum number of instances to be maintained
variable "MIN_INSTANCES" {
  default = 2
}

# maximum number of instances thus must not be exceeded
variable "MAX_INSTANCES" {
  default = 4
}

# port at which the backend service is configured
variable "SERVICE_PORT" {
  default = "80"
}
