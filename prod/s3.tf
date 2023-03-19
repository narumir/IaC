data "archive_file" "lambda_hello_world" {
  type        = "zip"
  source_dir  = "${path.module}/blog"
  output_path = "${path.module}/blog.zip"
}

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

resource "aws_s3_object" "blog_object" {
  bucket = aws_s3_bucket.blog_frontend.id
  key    = "blog.zip"
  source = data.archive_file.lambda_hello_world.output_path
  etag   = filemd5(data.archive_file.lambda_hello_world.output_path)
}
