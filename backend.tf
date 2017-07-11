terraform {
  backend "s3" {
    bucket = "rancher-terraform-aws"
    key    = "gocd"
    region = "eu-west-1"
  }
}
