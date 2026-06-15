output "ls_framework_discovery_services_arns" {
  value = {
    for k, v in aws_service_discovery_service.ls_framework_discovery_services :
    k => v.arn
  }
}
# output "ls_framework_discovery_services" {
#   value = aws_service_discovery_service.ls_framework_discovery_services.arn
# }