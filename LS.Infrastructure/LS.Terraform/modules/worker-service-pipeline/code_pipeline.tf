resource "aws_codepipeline" "ls_framework_codepipeline" {
    name     = "${var.service_name}-ecs-rolling"
    role_arn = aws_iam_role.ls_framework_worker_service_codepipeline_role.arn

    # trigger {
    #     provider_type = "CodeStarSourceConnection"
    #   git_configuration {
    #     source_action_name = "Source"
    #     push {
    #         branches {
    #           includes = [ "main" ]
    #         }
    #       file_paths {
    #         includes = [ "src/LS.WorkerService/**", "src/LS.Shared/**" ]
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
            ProjectName = aws_codebuild_project.ls_framework_ecs_rolling_build.name
        }
    }
  }

  stage {
    name = "Deploy"
    action {
        name     = "Deploy"
        category = "Deploy"
        owner    = "AWS"
        provider = "ECS"
        version = "1"

        input_artifacts = ["build_output"]

        configuration = {
            ClusterName = var.ls_framework_ecs_cluster_name
            ServiceName = "${var.service_name}-service"
            FileName    = "imagedefinitions.json"
        }
    }
  }
}