import {
  to = aws_lambda_function.this
  id = "manually-created"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.root}/build/index.mjs"
  output_path = "${path.root}/lambda.zip"
}

resource "aws_lambda_function" "this" {
  description      = "A starter AWS Lambda function."
  filename         = data.archive_file.lambda.output_path
  function_name    = "manually-created"
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  role             = aws_iam_role.lambda_execution_role.arn
  runtime          = "nodejs22.x"
  tags = {
    "lambda-console:blueprint" = "hello-world"
  }
  tags_all = {
    "lambda-console:blueprint" = "hello-world"
  }
  timeout = 3
  ephemeral_storage {
    size = 512
  }
  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/manually-created"
  }
}

# =====================
# Lambda Exeuction Role
# =====================
import {
  to = aws_iam_role.lambda_execution_role
  id = "manually-created-role-y89ux6n4"
}

import {
  to = aws_iam_policy.lambda_execution
  id = "arn:aws:iam::113817973311:policy/service-role/AWSLambdaBasicExecutionRole-6da4d6e9-727a-4771-8f89-afa308a4b981"
}

data "aws_iam_policy_document" "lambda_execution" {
  statement {
    effect    = "Allow"
    actions   = ["logs:CreateLogGroup"]
    resources = ["arn:aws:logs:us-east-1:113817973311:*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:logs:us-east-1:113817973311:log-group:/aws/lambda/manually-created:*"]
  }
}

resource "aws_iam_policy" "lambda_execution" {
  name   = "AWSLambdaBasicExecutionRole-6da4d6e9-727a-4771-8f89-afa308a4b981"
  path   = "/service-role/"
  policy = data.aws_iam_policy_document.lambda_execution.json
}

data "aws_iam_policy_document" "assume_lambda_execution_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_lambda_execution_role.json
  name               = "manually-created-role-y89ux6n4"
  path               = "/service-role/"
}

resource "aws_iam_role_policy_attachment" "lambda_execution_role_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_execution.arn
}