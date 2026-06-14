locals {
    env_context = {
        aws_region = var.aws_region
        project_name = var.project_name
        environment = var.environment
        managed_by   = var.managed_by

        resource_prefix = "${local.env_context.project_name}-${local.env_context.environment}"
    }
}