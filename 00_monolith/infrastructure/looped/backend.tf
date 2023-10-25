terraform {
  backend "s3" {
    bucket = "terraform-state-202151242785-us-west-1"
    key    = "monolith"
    region = "us-west-1"
  }
}