provider "aws" {
  region = "ap-south-1"
}

# Create an S3 bucket
resource "aws_s3_bucket" "bucket-example" {
  bucket = "expdep-bucket"
}

# Create an IAM role with an explicit dependency on the S3 bucket
resource "aws_iam_role" "example" {
  name = "expdep-example-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  # Explicitly depend on the S3 bucket
  depends_on = [aws_s3_bucket.bucket-example]
}
