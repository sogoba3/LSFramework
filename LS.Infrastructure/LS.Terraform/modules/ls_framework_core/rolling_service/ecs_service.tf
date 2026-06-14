resource "aws_ecs_service" "ls_framework_ecs_service_name" {
  name = "${var.service_name}-service"
  cluster = var.ls_framework_ecs_cluster_id

  task_definition = var.ls_framework_task_definition_arn #aws_ecs_task_definition.ls_framework_ecs_task_definition_name.arn
  desired_count = var.desired_count
  launch_type = "FARGATE"
  #force_new_deployment = true
  deployment_controller {
    type = "ECS"
  }

  # this is only supported for ecs rolling
  # deployment_circuit_breaker {
  #   enable = true
  #   rollback = true
  # }

  # ECS NETWORKING
  network_configuration {
    assign_public_ip = false
    subnets = var.ls_framework_private_subnets

    security_groups = [
        var.ls_framework_ecs_service_sg_id
        #aws_security_group.ls_framework_ecs_service_sg.id
    ]
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent = 200
  enable_execute_command = true

  lifecycle {
    ignore_changes = [ task_definition ]
  }
  tags = {
    Name = "internal-api-service"
  }
}