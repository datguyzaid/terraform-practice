resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "static-website" {
  bucket = "static-website-datguyzaid-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket_public_access_block" "static-website_public_access" {
  bucket = aws_s3_bucket.static-website.id
  block_public_acls = true
  block_public_policy = false
  ignore_public_acls = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static-website_public_read" {
  bucket = aws_s3_bucket.static-website.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Sid = "PublicReadObject"
            Effect = "Allow"
            Principal = "*"
            Action = "S3:GetObject"
            Resource = "${aws_s3_bucket.static-website.arn}/*"
        }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static-website.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.static-website.id
  key = "index.html"
  source = "build/index.html"
  etag = filemd5("build/index.html")
  content_type = "text/html"
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.static-website.id
  key = "error.html"
  source = "build/error.html"
  etag = filemd5("build/error.html")
  content_type = "text/html"
}