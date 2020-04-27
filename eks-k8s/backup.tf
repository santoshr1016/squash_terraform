terraform {
  required_version = ">= 0.11.9"

  backend "s3" {
    encrypt        = true
    bucket         = "torus-test-123"
    region         = "us-east-1"
    dynamodb_table = "torus-tf-state-lock"
    key            = "states/eks-k8s.tfstate"
  }
}