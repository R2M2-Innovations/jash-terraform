terraform { 
  backend "s3" {
    profile = "r2m2"
    region = "us-east-1"
    bucket = "r2m2-tfstate-d"
    key = "terraform.tfstate"
    workspace_key_prefix = "vpc"
    encrypt = "true"
  }
}
