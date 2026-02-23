resource "aws_iam_role" "terraform_exec" {
  name = "TerraformExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.security_account_id}:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  permissions_boundary = aws_iam_policy.security_boundary.arn
}

resource "aws_iam_role_policy_attachment" "terraform_exec_admin" {
  role       = aws_iam_role.terraform_exec.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
