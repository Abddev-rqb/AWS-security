resource "aws_cloudtrail" "org_trail" {
  name                          = "organization-trail"
  s3_bucket_name                = aws_s3_bucket.log_archive.bucket
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  is_organization_trail         = true
  include_global_service_events = true

  depends_on = [
    aws_s3_bucket_policy.log_archive_policy
  ]
}
