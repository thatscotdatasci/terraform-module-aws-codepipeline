resource "aws_codepipeline" "this" {
  name     = "${var.codepipeline_name}"
  role_arn = "${var.iam_role_arn}"

  artifact_store {
    location = "${var.s3_artifact_bucket_arn}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name     = "Source"
      category = "Source"
      owner    = "ThirdParty"
      provider = "GitHub"
      version  = "1"

      output_artifacts = [
        "SourceCode",
      ]

      configuration {
        Owner                = "${var.github_owner}"
        Repo                 = "${var.github_repo}"
        Branch               = "${var.github_branch}"
        PollForSourceChanges = "${var.github_poll}"
        OAuthToken           = "${var.github_oauth}"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name     = "Build"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"

      input_artifacts = [
        "SourceCode",
      ]

      output_artifacts = [
        "CompiledCode",
      ]

      version = "1"

      configuration {
        ProjectName = "${var.codebuild_name}"
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

      input_artifacts = [
        "CompiledCode",
      ]

      version = "1"

      configuration {
        ClusterName = "${var.ecs_cluster_name}"
        ServiceName = "${var.ecs_service_name}"
      }
    }
  }
}

resource "aws_codepipeline_webhook" "this" {
  count           = "${var.implement_webhook == true ? 1 : 0}"
  name            = "${var.codepipeline_name}-webhook"
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = "${aws_codepipeline.this.name}"

  authentication_configuration {
    secret_token = "${var.webhook_secret}"
  }

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/{Branch}"
  }
}

resource "github_repository_webhook" "this" {
  count      = "${var.implement_webhook == true ? 1 : 0}"
  repository = "${var.github_repo}"

  name = "web"

  configuration {
    url          = "${aws_codepipeline_webhook.this.url}"
    content_type = "form"
    insecure_ssl = false
    secret       = "${var.webhook_secret}"
  }

  events = [
    "push",
  ]
}
