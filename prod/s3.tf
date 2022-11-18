resource "aws_s3_bucket" "blog_frontend" {
  bucket = "blog-frontend-2546252"
  tags = {
    Name       = "blog-frontend-2546252"
    Enviroment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "blog_frontend_acl" {
  bucket = aws_s3_bucket.blog_frontend.id
  acl    = "private"
}
