resource "aws_s3_bucket" "receiver_bucket" {
  acl = "private"
  bucket = "${var.organisation_name}-controlshift-receiver"

  tags {
    Environment = "${var.environment}"
  }
}

resource "aws_s3_bucket" "manifests_bucket" {
  acl = "private"
  bucket = "${var.organisation_name}-controlshift-manifests"

  tags {
    Environment = "${var.environment}"
  }
}
