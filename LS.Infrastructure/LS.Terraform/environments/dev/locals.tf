locals {
  env_context = {
    aws_region   = var.aws_region
    project_name = var.project_name
    environment  = var.environment
    managed_by   = var.managed_by

    resource_prefix = "${var.project_name}-${var.environment}"

    ecr_repositories = [
      "gateway-api",
      "auth-api",
      "tenant-api",
      "patient-api",
      "doctor-api",
      "appointment-api",
      "billing-api",
      "notification-api",
      "audit-api",
      "worker-service",
      "file-service"
    ]

    # is_blue_green  = var.deployment_type == "BLUE_GREEN"
    # is_ecs_rolling = var.deployment_type == "ECS_ROLLING"
  }

}
