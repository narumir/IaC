resource "aws_s3_bucket" "blog_content" {
  bucket   = "blog-content"
  provider = aws.cloudflare
}

resource "aws_s3_bucket_cors_configuration" "blog_content" {
  bucket   = aws_s3_bucket.blog_content.id
  provider = aws.cloudflare
  cors_rule {
    allowed_methods = [
      "GET",
    ]
    allowed_origins = [
      "https://*.narumir.io",
      "http://localohst:3000",
    ]
  }
}
