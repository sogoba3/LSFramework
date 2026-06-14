
### Github OIDC Provider for LS FRAMEWORK CI/CD Pipeline
resource "aws_iam_openid_connect_provider" "ls_framework_oidc_github" {
    url = "https://token.actions.githubusercontent.com"
    client_id_list = [ "://amazonaws.com" ]
    ### this is a lagacy as of 2023 (Not required)
    # thumbprint_list = [ "6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd" ]
}

### # GITHUB ACTIONS ROLE
data "aws_iam_policy_document" "github_actions_assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type        = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.ls_framework_oidc_github.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:sogoba3/LSFramework:*"]
    }
  }
}
resource "aws_iam_role" "ls_framework_github_actions_role" {
    name = "${var.project_prefix}-github-actions-role"
    assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json
}

### GITHUB ACTIONS POLICY
data "aws_iam_policy_document" "github_actions_policy" {

  statement {
    sid    = "ECR"
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "ECS"
    effect = "Allow"

    actions = [
      "ecs:RegisterTaskDefinition",
      "ecs:UpdateService",
      "ecs:DescribeServices"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "S3"
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "CloudFront"
    effect = "Allow"

    actions = [
      "cloudfront:CreateInvalidation"
    ]

    resources = ["*"]
  }

  # Remove this if possible
  statement {
    sid    = "Terraform"
    effect = "Allow"

    actions = ["*"]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "ls_framework_github_actions_policy" {
  name   = "${var.project_prefix}-github-actions-policy"
  policy = data.aws_iam_policy_document.github_actions_policy.json
}

resource "aws_iam_role_policy_attachment" "ls_framework_github_actions" {
  role       = aws_iam_role.ls_framework_github_actions_role.name
  policy_arn = aws_iam_policy.ls_framework_github_actions_policy.arn
}

