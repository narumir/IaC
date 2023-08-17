resource "aws_s3_bucket" "blog_content" {
  bucket   = "blog-content"
  provider = aws.cloudflare_r2
}

resource "aws_s3_bucket_cors_configuration" "blog_content_cors" {
  bucket   = aws_s3_bucket.blog_content.id
  provider = aws.cloudflare_r2
  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = [
      "https://*.narumir.io",
      "http://localhost:3000",
      "https://*.execute-api.ap-northeast-2.amazonaws.com"
    ]
  }
}
