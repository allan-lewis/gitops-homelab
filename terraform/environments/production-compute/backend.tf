terraform {
  backend "s3" {
    bucket         = "gitops-homelab-terraform"
    key            = "gitops-homelab-production-compute/state.tfstate"   # Path inside the bucket
    region         = "us-east-1"
    encrypt        = true  # Ensures state is encrypted
  }
}
