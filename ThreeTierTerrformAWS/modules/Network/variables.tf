variable "tag_name" {
   default = "main-vpc"
}

variable "vpc-cidr" {
   default = "10.0.0.0/16"
}

#map of maps for create subnets
variable "webSubnets" {
   type = map
   default = {
      websubnet-1a = {
         az = "us-east-1a"
         cidr = "10.0.1.0/24"
      }
      websubnet-1b = {
         az = "us-east-1b"
         cidr = "10.0.2.0/24"
      }
 }
}

variable "AppSubnets" {
   type = map
   default = {
      Appsubnet-1a = {
         az = "us-east-1a"
         cidr = "10.0.3.0/24"
      }
      Appsubnet-1b = {
         az = "us-east-1b"
         cidr = "10.0.4.0/24"
      }
 }
}

 variable "DbSubnets" {
    type=map
     default = {
      Dbsubnet-1a = {
         az = "us-east-1a"
         cidr = "10.0.11.0/24"
      }
      DbSubnet-1b = {
         az = "us-east-1b"
         cidr = "10.0.12.0/24"
      }
 }
 }