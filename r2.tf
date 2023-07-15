resource "aws_s3_bucket" "blog_static" {
  bucket   = "blog-static"
  provider = aws.cloudflare_r2
  # 아직 cloudflare에서 도메인 연결 부분을 지원하지 않으므로 수동으로 등록 해야함.
}
