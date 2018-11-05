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

variable "lambda_deploy_function" {
  description = "Name of the Lambda function which will be used to deploy the built code"
}

variable "lambda_user_params" {
  description = "User parameters to be passed to the Lambda function which will deploy the built code"
}