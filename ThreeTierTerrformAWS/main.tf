terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "Network" {
    source="./modules/Network"  # us-east-1 , us-east-1a sub-1PUB 1PRI 1PRI , us-east-1b sub-1PUB 1PRI 1PRI 
}

module "WebInstance" {    #2PUB can also be PRI 
    source="./modules/WebInstance"
    vpc_id=module.Network.vpcId
    security_groups=module.Network.webserver-sg-id #allow inbound traffic from External ELB
    subnets=module.Network.websubnets
}

module "AppInstance"{  #2PRI
    source="./modules/AppInstance"
    vpc_id=module.Network.vpcId
    security_groups=module.Network.appserver-sg-id #allow inbound traffic from internal ALB
    subnets=module.Network.Appsubnets
}

module "DbInstance" { #2PRI
    source="./modules/DbInstance"
    vpc_id=module.Network.vpcId
    security_groups=module.Network.database-sg-id #allow inbound traffic from appserver-sg-id
    subnets=module.Network.Dbsubnets
}


module "LoadBalancer" {
    source="./modules/LoadBalancer"
    vpc_id=module.Network.vpcId
    security_groups_web=module.Network.ExternalWebELB-sg-id
    subnets_web=module.Network.websubnets
    target_id_web=module.WebInstance.id
    security_groups_app=module.Network.InternalAppElb-id
    subnets_app=module.Network.Appsubnets
    target_id_app=module.WebInstance.id
}