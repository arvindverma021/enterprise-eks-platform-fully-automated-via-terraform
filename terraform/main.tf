module "vpc" {
  source = "./modules/vpc"
}

module "ecr_fastapi" {
  source = "./modules/ecr"

  repository_name = "fastapi-app"
}


module "eks" {
  source = "./modules/eks"

  cluster_name       = "enterprise-eks"
  private_subnet_ids = module.vpc.private_subnet_ids
}


module "monitoring" {
  source = "./modules/monitoring"

  depends_on = [
    module.eks
  ]
}
