output "ls_framework_discovery_services_arns" {
  value = {
    for k, v in aws_service_discovery_service.ls_framework_discovery_services :
    k => v.arn
  }
}
output "ls_framework_discovery_service_dns" {
  value = {
    for k, v in aws_service_discovery_service.ls_framework_discovery_services :
    k => "http://${v.name}.${aws_service_discovery_private_dns_namespace.ls_framework_ns.name}"
  }
}
# output "ls_framework_discovery_services" {
#   value = aws_service_discovery_service.ls_framework_discovery_services.arn
# }