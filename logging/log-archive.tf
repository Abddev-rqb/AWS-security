resource "aws_s3_bucket" "log_archive" {
  bucket = "org-log-archive-secure"

  lifecycle {
    prevent_destroy = true
  }
}
resource "aws_s3_bucket_versioning" "log_archive_versioning" {
  bucket = aws_s3_bucket.log_archive.id

  versioning_configuration {
    status = "Enabled"
  }
}
