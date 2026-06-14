resource "aws_codestarconnections_connection" "ls_framework_github" {
  name          = "github-connection"
  provider_type = "GitHub"
}

resource "aws_codepipeline" "ls_framework_frontend_pipeline" {

  name     = "${var.service_name}-pipeline"
  role_arn = aws_iam_role.ls_framework_frontend_codepipeline_role.arn

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
    name = "BuildAndDeploy"

    action {
      name            = "BuildAndDeploy"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"

      input_artifacts = ["source_output"]

      configuration = {
        ProjectName = aws_codebuild_project.ls_framework_frontend_codebuild.name
      }
    }
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "ls_framework_frontend_codepipeline_role" {
  name               = "${var.service_name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      var.ls_framework_pipeline_artifacts_bucket_arn,
      "${var.ls_framework_pipeline_artifacts_bucket_arn}/*"
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["codestar-connections:UseConnection"]
    resources = [aws_codestarconnections_connection.ls_framework_github.arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "codepipeline_policy"
  role   = aws_iam_role.ls_framework_frontend_codepipeline_role.id
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}

data "aws_kms_alias" "s3kmskey" {
  name = "alias/aws/s3"
}