resource "aws_s3_bucket" "receiver_bucket" {
  acl = "private"

  tags {
    Name = "${var.organisation_name}-controlshift-receiver"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "manifests_bucket" {
  acl = "private"

  tags {
    Name = "${var.organisation_name}-controlshift-manifests"
    Environment = "Dev"
  }
}
