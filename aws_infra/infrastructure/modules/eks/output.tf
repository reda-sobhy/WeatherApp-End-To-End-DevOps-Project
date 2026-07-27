output "cluster_endpoint" {
  value       = aws_eks_cluster.this.endpoint
  description = "URL to Kubernetes API"
}

output "cluster_name" {
  value       = aws_eks_cluster.this.name
  description = "Cluster name"
}

output "cluster_certificate_authority" {
  value       = aws_eks_cluster.this.certificate_authority[0].data
  description = "Cluster CA for TLS connection"
}

output "node_role_arn" {
  value       = aws_iam_role.eks_node_role.arn
  description = "Node IAM role"
}
output "oidc_provider_arn" {
  description = "OIDC Provider ARN for IRSA"
  value       = aws_iam_openid_connect_provider.this.arn
}

output "cluster_oidc_issuer_url" {
  description = "OIDC issuer URL for IRSA"
  value       = aws_eks_cluster.this.identity[0].oidc[0].issuer
}



output "cluster_security_group_id" {
  description = "EKS Cluster Security Group"
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}
