// policy and role for copy to s3 lambda
resource "aws_iam_policy" "policy_for_copy_to_s3_lambda" {
  name        = "copy-to-s3-policy"
  policy      = "${file("roles/s3_policy.json")}"
}

resource "aws_iam_role" "iam_for_copy_to_s3_lambda" {
  name               = "copy-to-s3-role"
  assume_role_policy = "${file("roles/assume_role_policy.json")}"
}

resource "aws_iam_policy_attachment" "copy_to_s3_lambda_policy_attachment" {
  name       = "copy-to-s3-attachment"
  roles      = ["${aws_iam_role.iam_for_copy_to_s3_lambda.name}"]
  policy_arn = "${aws_iam_policy.policy_for_copy_to_s3_lambda.arn}"
}

// policy and role for redshift loader lambda
resource "aws_iam_policy" "policy_for_redshift_lambda" {
  name        = "redshift-loader-policy"
  policy      = "${file("roles/redshift_lambda_policy.json")}"
}

resource "aws_iam_role" "iam_for_redshift_lambda" {
  name        = "load-to-redshift-role"
  assume_role_policy = "${file("roles/assume_role_policy.json")}"
}

resource "aws_iam_policy_attachment" "redshift_lambda_attachment" {
  name       = "redshift-lambda-attachment"
  roles      = ["${aws_iam_role.iam_for_redshift_lambda.name}"]
  policy_arn = "${aws_iam_policy.policy_for_redshift_lambda.arn}"
}