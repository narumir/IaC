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
      "ssm:GetParametersByPath",
    ]
    resources = [
      "arn:aws:ssm:ap-northeast-2:${data.aws_caller_identity.current.account_id}:parameter/blog",
      "arn:aws:ssm:ap-northeast-2:${data.aws_caller_identity.current.account_id}:parameter/blog/*",
    ]
  }
}

resource "aws_iam_role_policy" "ec2_role" {
  name   = "ec2-role"
  role   = aws_iam_role.ec2_role.id
  policy = data.aws_iam_policy_document.ec2_role_ssm.json
}
