output "cp_cluster_name" {
  value = aws_eks_cluster.control_plane_cluster.name
  description = "name of EKS control plane cluster"
}

output "cp_cluster_arn" {
  value = aws_eks_cluster.control_plane_cluster.arn
  description = "ARN of EKS control plane cluster"
}

output "endpoint" {
  value = aws_eks_cluster.control_plane_cluster.endpoint
  description = "endpoint of kubernetes cluster"
}

output "ca" {
  value = aws_eks_cluster.control_plane_cluster.certificate_authority
  description = "CA of the kubernetes cluster"
}

