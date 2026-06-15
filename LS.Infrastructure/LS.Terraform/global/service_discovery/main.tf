resource "aws_service_discovery_private_dns_namespace" "ls_framework_ns" {
  name = "ls-framework.local"
  description = "Service discovery namespace for LS Framework"
  vpc = var.ls_framework_vpc_id
}
