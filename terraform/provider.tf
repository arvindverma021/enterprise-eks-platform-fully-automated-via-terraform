provider "aws" {
  region = "ap-south-1"

  default_tags {
    tags = {
      Project     = "Enterprise-EKS-Platform"
      Environment = "Dev"
      ManagedBy   = "Terraform"
    }
  }
}



provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_ca)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"

      command = "aws"

      args = [
        "eks",
        "get-token",
        "--cluster-name",
        module.eks.cluster_name
      ]
    }
  }
}
