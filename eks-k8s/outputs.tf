output "kubeconfig" {
  value = module.masterK8S.kubeconfig
}

output "config-map-aws" {
  value = module.workerK8S.config-map-aws-auth
}
