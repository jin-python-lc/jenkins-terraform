terraform {
  required_version = ">=0.13"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "3.42.0"
    }
  }

  backend "s3" {
    bucket = "trackmarket-jenkins"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
  
}
