resource "aws_s3_bucket" "blog_static" {
  bucket   = "blog-static"
  provider = aws.cloudflare_r2
  # 아직 cloudflare에서 도메인 연결 부분을 지원하지 않으므로 수동으로 등록 해야함.
}

resource "aws_s3_bucket_cors_configuration" "blog_static_cors" {
  bucket   = aws_s3_bucket.blog_static.id
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
