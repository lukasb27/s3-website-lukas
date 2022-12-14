variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "website_files_path" {
  type        = string
  description = "the path for folder that the website files are stored in"
}

variable "r53_zone_name" {
  type        = string
  description = "the zone name for public route53 zone"
}

variable "root_html_path" {
  type = string
  description = "the path for the root object of the website"
}

variable "git_repo" {
  type = string
  description = "The git repo to upload to s3"
}

variable "git_user" {
  type = string
  description = "The owner (user) of the git repo"
}

variable "git_branch" {
  type = string
  description = "The git branch to clone, ie dev, staging, prod."
}