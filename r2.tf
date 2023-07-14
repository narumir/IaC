resource "aws_s3_bucket" "test_r2" {
  bucket   = "test-r2-b"
  provider = aws.cloudflare_r2
}
