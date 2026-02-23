resource "aws_iam_policy" "security_boundary" {
  name   = "security-permission-boundary"
  policy = file("${path.module}/boundary-security-max.json")
}
