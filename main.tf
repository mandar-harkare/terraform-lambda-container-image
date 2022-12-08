provider "aws" {
  region = var.aws_region
}

provider "archive" {}
data "archive_file" "zip" {
  type        = "zip"
  source_file = "mh_test.py"
  output_path = "mh_test.zip"
}

resource "aws_lambda_function" "lambda" {
  function_name    = "MHTest"
  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "mh_test.lambda_handler"
  runtime          = "python3.9"
  timeout          = 900
}

resource "aws_lambda_function" "lambda_container" {
  depends_on = [
    null_resource.ecr_image
  ]
  function_name = "${local.prefix}-lambda"
  role          = aws_iam_role.iam_for_lambda.arn
  timeout       = 300
  image_uri     = "${aws_ecr_repository.repo.repository_url}@${data.aws_ecr_image.lambda_image.id}"
  package_type  = "Image"
}