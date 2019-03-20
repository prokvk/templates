provider "aws" {
	region = "${var.aws_region}"
}

resource "aws_s3_bucket" "b" {
	bucket = "${var.tf_be_bucket}"
	acl = "private"
	server_side_encryption_configuration = {
		rule {
			apply_server_side_encryption_by_default {
				sse_algorithm = "AES256"
			}
		}
	}
}

resource "aws_dynamodb_table" "t" {
	name = "${var.tf_be_ddb}"
	billing_mode = "PROVISIONED"
	read_capacity = 1
	write_capacity = 1
	hash_key = "LockID"

	attribute {
		name = "LockID"
		type = "S"
	}
}
