resource "aws_s3_bucket" "blog_frontend" {
  bucket = "blog-${random_uuid.blog_frontend_s3.result}"
  tags = {
    Name = "blog-frontend"
  }
}

resource "aws_s3_bucket_acl" "blog_frontend_acl" {
  bucket = aws_s3_bucket.blog_frontend.id
  acl    = "private"
}
