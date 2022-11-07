variable "vpc_id" {}
variable "security_groups" {}
variable "subnets" {}

variable "engine" {
    type=string
    default="mysql"
}

variable "engine_version" {
    type=string
    default="7.0.20"
}

variable "instance_class" {
    type=string
    default="db.t2.micro"
}

variable "db_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}