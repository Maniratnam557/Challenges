variable "vpc_id" {}
variable "security_groups" {}
variable "subnets" {}
variable "instance_type" {
    type=string
    default=t2.micro
}
variable "ami" {
    type=string
    default="ami-0d5eff06f840b45e9"
}