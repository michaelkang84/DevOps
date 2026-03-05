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
  role             = "arn:aws:iam::113817973311:role/service-role/manually-created-role-y89ux6n4"
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