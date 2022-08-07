resource "aws_iam_policy" "policy" {
  name        = "test_policy1"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = join(":", ["arn:aws:ec2:*", var.account_id, "terraform/*"])
      },
    ]
  })
}

variable "account_id" {
    default = "117091474022"
}