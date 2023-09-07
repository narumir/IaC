resource "aws_s3_bucket" "blog-content" {
  bucket_prefix = "blog-content-"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "blog-content" {
  bucket = aws_s3_bucket.blog-content.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

data "aws_iam_policy_document" "blog-content-lambda-assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role" "blog-content-lambda" {
  name               = "blog-content-lambda"
  assume_role_policy = data.aws_iam_policy_document.blog-content-lambda-assume.json
}

data "aws_iam_policy_document" "blog-content-lambda-policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.blog-content.bucket}/",
      "arn:aws:s3:::${aws_s3_bucket.blog-content.bucket}/*",
    ]
  }
}

resource "aws_iam_policy" "blog-content-lambda" {
  name   = "blog-content-lambda-role"
  policy = data.aws_iam_policy_document.blog-content-lambda-policy.json
}

resource "aws_iam_role_policy_attachment" "blog-content-lambda" {
  role       = aws_iam_role.blog-content-lambda.name
  policy_arn = aws_iam_policy.blog-content-lambda.arn
}

resource "aws_iam_role_policy_attachment" "blog-content-lambda-execution" {
  role       = aws_iam_role.blog-content-lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_s3_object" "blog-content-resizer-code" {
  bucket = aws_s3_bucket.code_store.id
  key    = "resizer/lambda.zip"
}

resource "aws_lambda_function" "blog-content" {
  role              = aws_iam_role.blog-content-lambda.arn
  handler           = "index.handler"
  runtime           = "nodejs18.x"
  function_name     = "blog-content-resizer"
  s3_bucket         = data.aws_s3_object.blog-content-resizer-code.bucket
  s3_key            = data.aws_s3_object.blog-content-resizer-code.key
  s3_object_version = data.aws_s3_object.blog-content-resizer-code.version_id
  environment {
    variables = {
      REGION = "ap-northeast-2",
      BUCKET = aws_s3_bucket.blog-content.bucket
    }
  }
}

resource "aws_lambda_permission" "blog-content" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.blog-content.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.blog-content.execution_arn}/*/*"
}

resource "aws_apigatewayv2_api" "blog-content" {
  name          = "blog-content"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "blog-content" {
  api_id             = aws_apigatewayv2_api.blog-content.id
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.blog-content.invoke_arn
}

resource "aws_apigatewayv2_route" "blog-content" {
  api_id    = aws_apigatewayv2_api.blog-content.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.blog-content.id}"
}

resource "aws_apigatewayv2_stage" "blog-content" {
  api_id      = aws_apigatewayv2_api.blog-content.id
  name        = "prod"
  auto_deploy = true
}

resource "aws_apigatewayv2_domain_name" "blog-content" {
  domain_name = "content-blog.narumir.io"
  domain_name_configuration {
    certificate_arn = aws_acm_certificate.narumir_io.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api_mapping" "blog-content" {
  api_id      = aws_apigatewayv2_api.blog-content.id
  domain_name = aws_apigatewayv2_domain_name.blog-content.domain_name
  stage       = aws_apigatewayv2_stage.blog-content.id
}
