output "vpcId" {
    value=aws_vpc.app-vpc.id
}

output "websubnets" {
    value=[aws_subnet.web-subnet["websubnet-1a"].id,aws_subnet.web-subnet["websubnet-1b"].id ]
}

output "Appsubnets" {
    value= [aws_subnet.app-subnet["Appsubnet-1a"].id,aws_subnet.web-subnet["Appsubnet-1a"].id ]
}

output "Dbsubnets" {
    value= [aws_subnet.dbSubnet["Dbsubnet-1a"].id,aws_subnet.web-subnet["Dbsubnet-1a"].id ]
}

output "ExternalWebELB-sg-id" {
    value=aws_security_group.ExternalWebELB-sg-id.id
}

output "webserver-sg-id" {
    value=aws_security_group.webserver-sg.id
}

output "InternalAppElb-id" {
    value=aws_security_group.InternalAppElb.id
}

output "appserver-sg-id" {
    value=aws_security_group.appserver-sg-id
}

output "database-sg-id" {
    value=aws_security_group.database-sg.id
}

