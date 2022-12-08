data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

data "aws_iam_policy_document" "cloudwatch_policy_doc" {
  statement {
    sid    = "VisualEditor0"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_mh_test"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_policy" "cloudwatch_policy" {
  name   = "mh-test-pol"
  policy = data.aws_iam_policy_document.cloudwatch_policy_doc.json
}

resource "aws_iam_policy_attachment" "cloudwatch_policy_doc_attach" {
  name       = "cloudwatch_policy_doc_attachment"
  roles      = ["${aws_iam_role.iam_for_lambda.name}"]
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
}