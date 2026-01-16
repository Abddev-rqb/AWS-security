resource "aws_organizations_policy" "this" {
  name        = var.policy_name
  description = var.policy_description
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DenyS3BucketCreationInUsEast1"
        Effect = "Deny"
        Action = [
          "s3:CreateBucket"
        ]
        Resource = ["*"]
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = "us-east-1"
          }
        }
      }
    ]
  })
}
