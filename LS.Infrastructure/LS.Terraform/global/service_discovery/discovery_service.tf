resource "aws_service_discovery_service" "ls_framework_discovery_services" {
  for_each = var.services
  name = each.value.name

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.ls_framework_ns.id
    dns_records {
      ttl = 10
      type = "A"
    }
    routing_policy = "MULTIVALUE"
  }
  # health_check_config {
  #   type = "HTTP"
  #   failure_threshold = 1
  # }
}