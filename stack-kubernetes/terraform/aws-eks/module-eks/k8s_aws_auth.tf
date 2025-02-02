resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  data = {
    mapRoles = <<MAPROLES
        - rolearn: ${aws_iam_role.eks-node.arn}
          username: system:node:{{EC2PrivateDNSName}}
          groups:
            - system:bootstrappers
            - system:nodes
MAPROLES
  }

  depends_on = [
    aws_iam_role.eks-node,
    aws_eks_cluster.eks-cluster,
  ]
}