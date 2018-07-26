resource "aws_lambda_function" "copy_to_s3" {
  filename          = "lambda_scripts/copy_to_s3.js"
  role             = "${aws_iam_role.iam_for_copy_to_s3_lambda.arn}"
  handler          = "exports.test"
  runtime          = "nodejs8.10"
  function_name    = "copyToS3"
  timeout          = 30
  environment {
    variables = {
      S3_BUCKET = "${var.organisation_name}-controlshift-receiver"
    }
  }
}

resource "aws_lambda_function" "load_to_redshift_lambda" {
  s3_bucket         = "awslabs-code-us-east-1"
  s3_key            = "LambdaRedshiftLoader/AWSLambdaRedshiftLoader-2.5.0.zip"
  role             = "${aws_iam_role.iam_for_redshift_lambda.arn}"
  handler          = "exports.test"
  runtime          = "nodejs8.10"
  function_name    = "loadToRedshift"
  environment {
    variables = {
    }
  }
}
