data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_name}/*",
    ]
  }
}

resource "null_resource" "git_clone" {
  provisioner "local-exec" {
    command = "git clone --branch ${var.git_branch} git@github.com:${var.git_user}/${var.git_repo}.git"
  }
}

resource "aws_s3_bucket_object" "index" {
  # Put the files located at the website path into the S3 bucket ready for hosting.
  # This should be a folder and contain at least 'index.html' or whatever
  # you define root_html_path as.

  # for each file in the folder
  depends_on = [
    null_resource.git_clone
  ]
  for_each = fileset(var.git_repo, "*")

  bucket = var.bucket_name
  key    = each.value
  source = "${var.git_repo}/${each.value}"
  etag   = filemd5("${var.git_repo}/${each.value}")
  content_type = "text/html"
}

module "s3_bucket" {
  # Create an empty s3 bucket that is configured for hosting html documents. 
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "2.14.1"
  attach_policy = true
  policy        = data.aws_iam_policy_document.bucket_policy.json
  bucket        = var.bucket_name
  acl           = "private"
  website = {
    index_document = var.root_html_path
    error_document = "error.html"
    routing_rules = jsonencode([{
      Condition : {
        KeyPrefixEquals : "docs/"
      },
      Redirect : {
        ReplaceKeyPrefixWith : "documents/"
      }
    }])
  }

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

