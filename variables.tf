variable "name" {
  description = "the name for EKS cluster"
  type = string
}

variable "min_workers" {
  description = "minimum number of nodes in cluster"
  type = number
}

variable "max_workers" {
  description = "maximum number of nodes in cluster"
  type = number
}

variable "desired_workers" {
  description = "desired number of nodes in cluster"
  type = number
}

variable "instance_types" {
  description = "ec2 instance type"
  type = list(string)
}
