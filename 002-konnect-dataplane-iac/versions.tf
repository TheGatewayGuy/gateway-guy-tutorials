terraform {
  required_providers {
    konnect = {
      source  = "kong/konnect"
      version = "2.5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.1"
    }
    helm = {
      source = "hashicorp/helm"
      version = "3.1.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "3.0.1"
    }
  }
}