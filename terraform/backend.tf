terraform {
	backend "s3" {
		bucket = "__BUCKET__"
		key = "default"
		region = "__REGION__"
		dynamodb_table = "__TABLE__"
	}
}
