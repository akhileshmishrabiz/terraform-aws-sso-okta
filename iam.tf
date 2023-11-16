# AWS SSO Role Okta
resource "aws_iam_role" "sso" {
  name               = var.sso_role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRoleWithSAML",
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.aws.amazon.com/saml"
        }
      },
      "Principal": {
        "Federated": "arn:aws:iam::${var.aws_account_id}:saml-provider/${aws_iam_saml_provider.sso.id}"
      }
    }
  ]
}	
EOF
}

# sso role policy
resource "aws_iam_policy" "sso" {
  name        = "${var.sso_role_name}-policy"
  path        = "/"
  description = "AWS SSO role for okta"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "eks:AccessKubernetesApi",
            "eks:DescribeCluster",
            "eks:DescribeFargateProfile",
            "eks:DescribeNodegroup",
            "eks:DescribeUpdate",
            "eks:ListClusters",
            "eks:ListFargateProfiles",
            "eks:ListNodegroups",
            "eks:ListTagsForResource",
            "eks:ListUpdates"
          ],
          "Resource" : "*"
        }
      ]
  })
}



resource "aws_iam_role_policy_attachment" "sso" {
  role       = aws_iam_role.sso.name
  policy_arn = aws_iam_policy.sso.arn
}

# service user 
resource "aws_iam_user" "sso_user" {
  name = var.sso_user
  path = "/services/"
}

resource "aws_iam_access_key" "sso" {
  user = aws_iam_user.sso_user.name
}

# service user policy
resource "aws_iam_policy" "sso_user" {
  name        = "sso_user_policy"
  path        = "/"
  description = "For Okta check in account"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:ListRoles",
          "iam:ListAccountAliases"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "sso" {
  user       = aws_iam_user.sso_user.name
  policy_arn = aws_iam_policy.sso_user.arn
}


