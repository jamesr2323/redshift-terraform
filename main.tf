provider "aws" {
  access_key = "AKIAJYEZ52WRMXS2E2PQ"
  secret_key = "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"
  region     = "us-east-1"
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


# s3://awslabs-code-\<REGION>/LambdaRedshiftLoader/AWSLambdaRedshiftLoader-2.5.0.zip
