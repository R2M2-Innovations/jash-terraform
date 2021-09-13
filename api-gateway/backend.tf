terraform {
  backend "s3" {
    profile              = "comcast-tf"
    region               = "us-west-2"
    bucket               = "sky-tfstate-uw2"
    key                  = "terraform.tfstate"
    workspace_key_prefix = "api-gateway"
    encrypt              = "true"
  }
}

