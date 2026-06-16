resource "aws_codepipeline" "ls_framework_codepipeline" {
    name     = "${var.service_name}-blue-green"
    role_arn = aws_iam_role.ls_framework_gateway_api_service_codepipeline_role.arn

    # trigger {
    #     provider_type = "CodeStarSourceConnection"
    #   git_configuration {
    #     source_action_name = "Source"
    #     push {
    #         branches {
    #           includes = [ "main" ]
    #         }
    #       file_paths {
    #         includes = [ "src/LS.Gateway/**", "src/LS.Shared/**" ]
    #       }
    #     }
    #   }
    # }
    
    artifact_store {
        location = var.ls_framework_pipeline_artifacts_bucket
        type     = "S3"

        encryption_key {
        id   = data.aws_kms_alias.s3kmskey.arn
        type = "KMS"
        }
    }

    stage {
    name = "Source"

    action {
        name             = "Source"

        category         = "Source"
        owner            = "AWS"
        provider         = "CodeStarSourceConnection"
        version          = "1"

        output_artifacts = ["source_output"]

        configuration = {
          ConnectionArn    = aws_codestarconnections_connection.ls_framework_github.arn
          FullRepositoryId = "sogoba3/LSFramework"
          BranchName       = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
        name             = "Build"
        category         = "Build"
        owner            = "AWS"
        provider         = "CodeBuild"
        version = "1"

        input_artifacts  = ["source_output"]
        output_artifacts = ["build_output"]

        configuration = {
            ProjectName = aws_codebuild_project.ls_framework_blue_green_build.name
        }
    }
  }

  stage {
    name = "Deploy"

    action {
        name     = "Deploy"
        category = "Deploy"
        owner    = "AWS"
        provider = "CodeDeployToECS"
        version = "1"

        input_artifacts = ["build_output"]

        configuration = {
            ApplicationName = aws_codedeploy_app.ls_framework_blue_green_codedeploy_app.name
            DeploymentGroupName = aws_codedeploy_deployment_group.ls_framework_blue_green_deployment_group.deployment_group_name

            TaskDefinitionTemplateArtifact = "build_output"
            TaskDefinitionTemplatePath     = "deploy/gateway-api/taskdef.json"

            AppSpecTemplateArtifact = "build_output"
            AppSpecTemplatePath     = "deploy/gateway-api/appspec.yaml"

            Image1ArtifactName             = "build_output"
            Image1ContainerName            = "IMAGE1_NAME"
        }
    }
  }
}