### EKS-OutPut-Kube-Config-Data
############################################################################
### EKS-Master-EndPoint

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.EKSCluster01.endpoint
}

output "eks_cluster_ca_data" {
  value = aws_eks_cluster.EKSCluster01.certificate_authority[0].data
}

### EKS-Master-Security-Group
output "eks_cluster_sg_01" {
  value = aws_security_group.EKSMasterSG01.id
}