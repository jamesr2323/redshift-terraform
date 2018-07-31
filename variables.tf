variable "organisation_name" {
	description = "A unique prefix, representing your organisation's name, which we'll prepend to created resources."
	type = "string"
}

variable "environment" {
  description = "The environment you're running this for. Defaults to 'Dev'"
  type = "string"
  default = "Dev"
}

variable "aws_region" {
  description = "The AWS region you're using."
  type = "string"
  default = "eu-west-1"
}
