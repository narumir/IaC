data "aws_iam_policy_document" "lambda_exec" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "blog_ssr" {
  version = "2012-10-17"
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
  name               = "labmda_exec"
  assume_role_policy = data.aws_iam_policy_document.lambda_exec.json
}

resource "aws_iam_role_policy_attachment" "blog_ssr" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.blog_ssr.arn
}
