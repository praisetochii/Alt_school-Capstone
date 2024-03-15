terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }

    kubernetes = {
        version = ">= 2.0.0"
        source = "hashicorp/kubernetes"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}


data "aws_eks_cluster" "feet-wox-eks-sockshop" {
  name = "feet-wox-eks-sockshop"
}
data "aws_eks_cluster_auth" "feet-wox-eks-sockshop_auth" {
  name = "feet-wox-eks-sockshop_auth"
}


provider "aws" {
  region     = "eu-west-2"
}

provider "helm" {
    kubernetes {
       #host                   = data.aws_eks_cluster.feet-wox-eks-sockshop.endpoint
      # cluster_ca_certificate = base64decode(data.aws_eks_cluster.feet-wox-eks-sockshop.certificate_authority[0].data)
       #token                  = data.aws_eks_cluster_auth.feet-wox-eks-sockshop_auth.token
      config_path = "~/.kube/config"
    }
}

provider "kubernetes" {
  #host                   = data.aws_eks_cluster.feet-wox-eks-sockshop.endpoint
 # cluster_ca_certificate = base64decode(data.aws_eks_cluster.feet-wox-eks-sockshop.certificate_authority[0].data)
  #token                  = data.aws_eks_cluster_auth.feet-wox-eks-sockshop_auth.token
 #  version          = "2.16.1"
  config_path = "~/.kube/config"
}

provider "kubectl" {
   load_config_file = false
   host                   = data.aws_eks_cluster.feet-wox-eks-sockshop.endpoint
   cluster_ca_certificate = base64decode(data.aws_eks_cluster.feet-wox-eks-sockshop.certificate_authority[0].data)
   token                  = data.aws_eks_cluster_auth.feet-wox-eks-sockshop_auth.token
    config_path = "~/.kube/config"
}


#export the kubeconfig file

#export KUBECONFIG=~/.kube/config