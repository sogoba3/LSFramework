resource "aws_codebuild_project" "ls_framework_blue_green_build" {
    name         = "${var.service_name}-build"
    service_role = aws_iam_role.ls_framework_gateway_api_service_codebuild_role.arn

    artifacts {
        type = "CODEPIPELINE"
    }

    source {
        type      = "CODEPIPELINE"
        buildspec = var.buildspec_path
    }

    environment {
    type = "LINUX_CONTAINER"
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    privileged_mode = true

    environment_variable {
      name  = "SERVICE_NAME"
      value = var.service_name
    }

    environment_variable {
      name  = "DOCKERFILE_PATH"
      value = var.dockerfile_path
    }
    environment_variable {
      name  = "TASK_EXECUTION_ROLE_ARN"
      value = var.ls_framework_ecs_task_execution_role_arn
    }

    environment_variable {
      name  = "TASK_ROLE_ARN"
      value = var.ls_framework_ecs_task_role_arn
    }
    environment_variable {
      name = "SQLSERVER_SECRET_ARN"
      value = var.ls_framework_sqlserver_secret_arn
    }
  }
}