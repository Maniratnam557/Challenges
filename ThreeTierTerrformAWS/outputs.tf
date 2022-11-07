output "ExternalWebELBDnsName" {
    value=module.LoadBalancer.Eternallb_dns_name
}

output "InternalAppElbDnsName" {
    value=module.LoadBalancer.AppInternal_Lb_dns_name
}

output "vpc_id" {
    value=module.Network.vpcId
}

output "websubnets" {
    value=module.Network.websubnets
}

output "Appsubnets" {
    value=module.Network.Appsubnets
}

output "Dbsubnets" {
    value=module.Network.Dbsubnets
}