terraform {
  backend "s3" {
    encrypt              = true
    key                  = "app.tfstate"
    workspace_key_prefix = "app"
  }
}