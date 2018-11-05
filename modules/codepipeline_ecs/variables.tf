variable "codepipeline_name" {
  description = "Name of the CodePipeline project"
}

variable "iam_role_arn" {
  description = "ARN of the IAM role used to run the pipeline"
}

variable "s3_artifact_bucket_arn" {
  description = "ARN of the S3 bucket which will contain the artifact once built"
}

variable "github_owner" {
  description = "Owner of the GitHub repo containing the source code to be built"
}

variable "github_repo" {
  description = "GitHub repo containing the source code to be built"
}

variable "github_branch" {
  description = "Branch of the GitHub repo containing the source code to be built"
}

variable "github_poll" {
  description = "Poll the GitHub repo containing the source code to be built for changes"
  default = true
}

variable "github_oauth" {
  description = "OAuth token for the GitHub repo containing the source code to be built"
}

variable "codebuild_name" {
  description = "Name of the CodeBuild project"
}

variable "ecs_cluster_name" {
  description = "Name of the Lambda function which will be used to deploy the built code"
}

variable "ecs_service_name" {
  description = "User parameters to be passed to the Lambda function which will deploy the built code"
}

variable "implement_webhook" {
  description = "Enable the creation of CodePipeline Webhook"
  default = true
}

variable "webhook_secret" {
  description = "A shared secret between GitHub and AWS that allows AWS CodePipeline to authenticate the request came from GitHub"
  default = ""
}