provider "aws" {
  profile    = "default"
  region     = var.region
}

# Bucket 1
resource "aws_s3_bucket" "shaheryar-malik-devops-terraform-bucket-1" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "${var.bucket1Name}"
  acl    = "private"
}

# Bucket 2
resource "aws_s3_bucket" "shaheryar-malik-devops-terraform-bucket-2" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "${var.bucket2Name}"
  acl    = "private"
}