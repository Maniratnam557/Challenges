output "Eternallb_dns_name" {
  description = "The DNS name of the external web load balancer"
  value       = aws_lb.external-elb.dns_name
}

output "AppInternal_Lb_dns_name" {
  value= aws_lb.internal_elb.dns_name
  description = "The DNS name of the internal app load balancer"
}
