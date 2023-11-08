resource "aws_eks_cluster" "control_plane_cluster" {
  name = var.name
  role_arn = aws_iam_role.control_plane_role.arn
  version = "1.28"
  vpc_config {
    subnet_ids = data.aws_subnets.default.ids
  }
  depends_on = [ aws_iam_role_policy_attachment.AmazonEKSClusterPolicy ]
}

resource "aws_eks_node_group" "worker_cluster" {
  cluster_name = aws_eks_cluster.control_plane_cluster.name
  node_group_name = var.name
  node_role_arn = aws_iam_role.worker_cluster.arn
  subnet_ids = data.aws_subnets.default.ids
  instance_types = var.instance_types
  scaling_config {
    min_size = var.min_workers
    max_size = var.max_workers
    desired_size = var.desired_workers
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
  ]
}
