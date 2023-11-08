### control plane
# role
resource "aws_iam_role" "control_plane_role" {
  name = "${var.name}-control-plane-role"
  assume_role_policy = data.aws_iam_policy_document.control_plane_assume_role.json
}

# policy
data "aws_iam_policy_document" "control_plane_assume_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

# attach permissions
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.control_plane_role.name
}

### workers
# role
resource "aws_iam_role" "worker_cluster" {
  name = "${var.name}-worker-cluster"
  assume_role_policy = data.aws_iam_policy_document.worker_assume_role.json
}

# policy
data "aws_iam_policy_document" "worker_assume_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# attach perms
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.worker_cluster.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.worker_cluster.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.worker_cluster.name
}

