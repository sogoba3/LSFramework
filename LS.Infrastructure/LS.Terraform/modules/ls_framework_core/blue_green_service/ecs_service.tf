resource "aws_ecs_service" "ls_framework_ecs_service_name" {
  name = "${var.service_name}-service"
  cluster = var.ls_framework_ecs_cluster_id

  task_definition = var.ls_framework_task_definition_arn #aws_ecs_task_definition.ls_framework_ecs_task_definition_name.arn
  desired_count = var.desired_count
  launch_type = "FARGATE"
  #force_new_deployment = true
  deployment_controller {
    type = "CODE_DEPLOY"
  }

  # ECS NETWORKING
  network_configuration {
    assign_public_ip = false
    subnets = var.ls_framework_private_subnets

    security_groups = [
        aws_security_group.ls_framework_gateway_service_sg.id,
        var.ls_framework_internal_services_sg_id
    ]
  }

  # ATTACH TO ALB
  load_balancer {
    target_group_arn = aws_lb_target_group.ls_framework_lb_blue_tg.arn
    container_name = var.service_name
    container_port = var.container_port
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent = 200
  enable_execute_command = true

  # service_registries {
  #   registry_arn = var.ls_framework_service_discovery_arn
  # }
  lifecycle {
    ignore_changes = [ task_definition ]
  }
  tags = {
    Name = "gateway-api-service"
  }
}