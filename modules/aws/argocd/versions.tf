terraform {
  required_version = ">= 1.5"
  required_providers {
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.18.1"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.11.0"
    }
    external = {
      source = "hashicorp/external"
      version = "2.3.1"
    }
  }
}
