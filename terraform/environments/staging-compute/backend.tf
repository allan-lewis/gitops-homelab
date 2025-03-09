terraform {
  backend "s3" {
    bucket         = "allans-homelab-terraform-state-bucket"
    key            = "staging-compute/state.tfstate"   # Path inside the bucket
    region         = "us-east-1"
    encrypt        = true  # Ensures state is encrypted
  }
}