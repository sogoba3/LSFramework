resource "aws_codepipeline" "ls_framework_terraform_state_codepipeline" {
    name     = "${var.service_name}-terraform-pipeline"
    role_arn = aws_iam_role.ls_framework_codepipeline_role.arn

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
            name             = "GitHub"
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
        name = "Plan"

        action {
            name            = "TerraformPlan"
            category        = "Build"
            owner           = "AWS"
            provider        = "CodeBuild"
            version          = "1"
            input_artifacts = ["source_output"]
            output_artifacts = ["plan_output"]

            configuration = {
              ProjectName = aws_codebuild_project.ls_framework_terraform_codebuild_plan.name
            }
        }
    }
  # Approval
  stage {

    name = "Approval"

    action {

      name = "ManualApproval"

      category = "Approval"

      owner = "AWS"

      provider = "Manual"

      version = "1"
    }
  }
  # Apply
  stage {

    name = "Apply"

    action {

      name = "TerraformApply"

      category = "Build"

      owner = "AWS"

      provider = "CodeBuild"

      version = "1"

      input_artifacts = ["plan_output"]

      configuration = {
          ProjectName = aws_codebuild_project.ls_framework_terraform_codebuild_apply.name
      }
    }
  }
}