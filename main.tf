terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
  access_key = ""
  secret_key = ""
}

# List of event themes
variable "event_themes" {
  default = [
    "AdventureTech",
    "NatureEscape",
    "DataSummit",
  ]
}

# Create S3 buckets based on event themes
resource "aws_s3_bucket" "event_buckets" {
  count = length(var.event_themes)

  bucket = "${var.event_themes[count.index]}-JS-bucket"  # Replace "JS" with your initials
  acl    = "private"

  # Additional configurations can be added here if needed
}

# Output the names of created buckets
output "created_bucket_names" {
  value = aws_s3_bucket.event_buckets[*].bucket
}
