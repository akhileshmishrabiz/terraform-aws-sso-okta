
# Archiving code for lambda
data "archive_file" "lambda_function_zip" {
  type        = "zip"
  source_dir  = "${path.module}/functions/key-rotatation-lambda"
  output_path = "${path.module}/key-rotatation-lambda.zip"
}

# Lambda function
resource "aws_lambda_function" "lambda_function" {
  function_name    = "key-rotatation-lambda"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "main.handler"
  runtime          = "python3.11"
  filename         = "${path.module}/key-rotatation-lambda.zip"
  depends_on       = [data.archive_file.lambda_function_zip]
  source_code_hash = data.archive_file.lambda_function_zip.output_base64sha256

  environment {
    variables = {
      SET_EXPIRY    = "90"
      KEY_USER_NAME = "key_user_name"
    }
  }
}

# IAM role to be used by lambda function
resource "aws_iam_role" "lambda_exec" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
      },
    ],
  })
}

# IAM policy for lambda to send email via AWS SES
resource "aws_iam_policy" "lambda_ses" {
  name        = "send-email-policy"
  description = "IAM policy for the Lambda function"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "ses:SendEmail",
            "ses:SendRawEmail",
            "iam:ListAccessKeys"
          ],
          "Resource" : "*"
        },
      ]
    }
  )
}

# Policy attachment
resource "aws_iam_policy_attachment" "lambda_attach" {
  name       = "lambda-attach-ses"
  policy_arn = aws_iam_policy.lambda_ses.arn
  roles      = [aws_iam_role.lambda_exec.name]
}

# Trigger for cloud function 
# Event rule
resource "aws_cloudwatch_event_rule" "cron_lambdas" {
  name                = "cronjob"
  description         = "to triggr lambda daily 8 am"
  schedule_expression = "cron(0  * * ? *)"
}

# Event target
resource "aws_cloudwatch_event_target" "cron_lambdas" {
  rule = aws_cloudwatch_event_rule.cron_lambdas.name
  arn  = aws_lambda_function.lambda_function.arn
}

# Invoke lambda permission
resource "aws_lambda_permission" "cron_lambdas" {
  statement_id  = "key-rotation-lambda-allow"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = aws_lambda_function.lambda_function.arn
  source_arn    = aws_cloudwatch_event_rule.cron_lambdas.arn
}
