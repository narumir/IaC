data "aws_iam_policy_document" "lambda_exec" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "blog_ssr" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:TagResource"
    ]
    resources = [
      aws_cloudwatch_log_group.blog_ssr.arn
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:PutLogEvent"
    ]
    resources = [
      aws_cloudwatch_log_group.blog_ssr.arn
    ]
  }
}

resource "aws_iam_policy" "blog_ssr" {
  name   = "blog_ssr"
  path   = "/"
  policy = data.aws_iam_policy_document.blog_ssr.json
}

resource "aws_iam_role" "lambda_exec" {
  name                = "labmda_exec"
  assume_role_policy  = data.aws_iam_policy_document.lambda_exec.json
  managed_policy_arns = [aws_iam_policy.blog_ssr.arn]
}
