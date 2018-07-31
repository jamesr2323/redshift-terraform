resource "aws_lambda_function" "copy_to_s3" {
  filename          = "lambda_scripts/bundles/copy_to_s3.js.zip"
  role             = "${aws_iam_role.iam_for_copy_to_s3_lambda.arn}"
  handler          = "copy_to_s3.handler"
  runtime          = "nodejs8.10"
  function_name    = "CopyToS3"
  timeout          = 30
  environment {
    variables = {
      S3_BUCKET = "${var.organisation_name}-controlshift-receiver"
    }
  }
}

resource "aws_lambda_function" "load_to_redshift_lambda" {
  s3_bucket         = "awslabs-code-${var.aws_region}"
  s3_key            = "LambdaRedshiftLoader/AWSLambdaRedshiftLoader-2.5.0.zip"
  role             = "${aws_iam_role.iam_for_redshift_lambda.arn}"
  handler          = "exports.handler"
  runtime          = "nodejs8.10"
  function_name    = "LambdaRedshiftLoader" // required for automated event handling
  environment {
    variables = {
    }
  }
}
