terraform {
  cloud {
    organization = "mateuszjanczak-jobs"
    workspaces {
      name = "jobs-infrastructure"
    }
  }

  required_providers {
    argocd = {
      source  = "argoproj-labs/argocd"
      version = "7.3.1"
    }
  }
}

provider "argocd" {
  server_addr = var.argocd_server
  username    = var.argocd_username
  password    = var.argocd_password
  grpc_web    = true
  insecure    = true
}