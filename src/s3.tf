resource "aws_s3_bucket" "trackmarket_s3" {
  bucket = "trackmarket-s3-bucket-terraform"
  acl    = "private"

  tags = {
    Name = "trackmarket_s3_terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "trackmarket_s3_block" {
  bucket                  = aws_s3_bucket.trackmarket_s3.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "trackmarket_s3_policy" {
  bucket = aws_s3_bucket.trackmarket_s3.id
  policy = data.aws_iam_policy_document.trackmarket_s3_policy_document.json
}

data "aws_iam_policy_document" "trackmarket_s3_policy_document" {
    statement {
        effect    = "Allow"
        actions   = ["s3:*"]
        resources = ["arn:aws:s3:::${aws_s3_bucket.trackmarket_s3.id}/*"]

        principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${var.account_id}:user/fullaccess2"]
        }
    }
}
