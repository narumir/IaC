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
      "${aws_cloudwatch_log_group.blog_ssr.arn}*:*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:PutLogEvents"
    ]
    resources = [
      "${aws_cloudwatch_log_group.blog_ssr.arn}*:*:*"
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

data "aws_iam_policy_document" "codedeploy_document" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "codedeploy_role" {
  name               = "codedeploy-role"
  assume_role_policy = data.aws_iam_policy_document.codedeploy_document.json
}

resource "aws_iam_role_policy_attachment" "codedeploy_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy_role.name
}

data "aws_iam_policy_document" "ec2_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_role.json
}

resource "aws_iam_role_policy_attachment" "ec2_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
  role       = aws_iam_role.ec2_role.name
}

resource "aws_iam_instance_profile" "ec2_role" {
  name = "ec2-role"
  role = aws_iam_role.ec2_role.name
}

data "aws_iam_policy_document" "ec2_role_ssm" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath"
    ]
    resources = [
      "arn:aws:ssm:ap-northeast-2:${data.aws_caller_identity.current.account_id}:parameter/blog",
      "arn:aws:ssm:ap-northeast-2:${data.aws_caller_identity.current.account_id}:parameter/blog/*"
    ]
  }
}

resource "aws_iam_role_policy" "ec2_role" {
  name   = "ec2-role"
  role   = aws_iam_role.ec2_role.id
  policy = data.aws_iam_policy_document.ec2_role_ssm.json
}
