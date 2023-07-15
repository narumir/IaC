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

resource "aws_iam_role" "lambda_exec" {
  name               = "labmda_exec"
  assume_role_policy = data.aws_iam_policy_document.lambda_exec.json
}
