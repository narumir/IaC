resource "aws_s3_bucket" "blog_ssr" {
  bucket = "blog-ssr-${random_uuid.blog_ssr_bucket.result}"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "blog_ssr" {
  bucket = aws_s3_bucket.blog_ssr.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

data "aws_s3_object" "blog_ssr_source_code" {
  bucket = aws_s3_bucket.blog_ssr.id
  key    = "blog_ssr.zip"
}

# data "aws_iam_policy_document" "blog_ssr_bucket" {
#   statement {
#     actions = ["s3:*"]
#     effect  = "Deny"
#     resources = [
#       "arn:aws:s3::${aws_s3_bucket.blog_ssr.arn}/*",
#       "arn:aws:s3:::${aws_s3_bucket.blog_ssr.arn}"
#     ]
#     condition {
#       test     = "Bool"
#       variable = "aws:SecureTransport"
#       values   = ["false"]
#     }
#   }
# }

# resource "aws_s3_bucket_policy" "blog_ssr" {
#   bucket = aws_s3_bucket.blog_ssr.id
#   policy = data.aws_iam_policy_document.blog_ssr_bucket.json
# }
