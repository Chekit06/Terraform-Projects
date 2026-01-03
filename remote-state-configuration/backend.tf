terraform {
  backend "s3" {
    bucket = "chekit-terraform-state-bucket-2026"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
    #dynamodb_table = "terraform-state-lock"
    use_lockfile = true
    encrypt = true
    
  }
}