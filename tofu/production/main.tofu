terraform {
  required_version = "1.9.0"
  backend "s3" {
    # Values provided by -backend-config in CI
    bucket = ""
    key    = ""
    region = ""
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.2.0"
    }
  }
}

