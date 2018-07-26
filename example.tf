provider "aws" {
  access_key = "AKIAJYEZ52WRMXS2E2PQ"
  secret_key = "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"
  region     = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  acl    = "private"

  tags {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "test-role"
  assume_role_policy = "${file("assume_role_policy.json")}"
}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"
  policy      = "${file("redshift_lambda_policy.json")}"
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  roles      = ["${aws_iam_role.iam_for_lambda.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_lambda_function" "copy_to_s3_lambda" {
  filename          = "copy_to_s3.js"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "exports.test"
  runtime          = "nodejs8.10"
  function_name    = "copyToS3"
  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_lambda_function" "load_to_redshift_lambda" {
  s3_bucket         = "awslabs-code-us-east-1"
  s3_key            = "LambdaRedshiftLoader/AWSLambdaRedshiftLoader-2.5.0.zip"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "exports.test"
  runtime          = "nodejs8.10"
  function_name    = "loadToRedshift"
  environment {
    variables = {
      foo = "bar"
    }
  }
}

# s3://awslabs-code-\<REGION>/LambdaRedshiftLoader/AWSLambdaRedshiftLoader-2.5.0.zip
