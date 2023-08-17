resource "aws_s3_bucket" "narumir_io_code_store" {
  bucket = "narumir-io-code-store"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "narumir_io_code_store" {
  bucket = aws_s3_bucket.narumir_io_code_store.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
