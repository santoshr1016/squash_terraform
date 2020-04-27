### 01.Module-VPC-Creation
module "vpcK8S" {
  source = "./modules/vpcK8S"
}

### 02.Module-EKS-Cluster-Master-Creation
module "masterK8S" {
  source              = "./modules/masterK8S"
  Public_SN_01_out_01 = module.vpcK8S.vpc01_public_subnet_01_id
  Public_SN_02_out_02 = module.vpcK8S.vpc01_public_subnet_02_id
  Public_SN_03_out_03 = module.vpcK8S.vpc01_public_subnet_03_id
  Public_SG_out       = [module.vpcK8S.vpc_public_sg]
  vpc_id_output       = module.vpcK8S.vpc_id
}

### 03.Module-EKS-Cluster-Nodes-Creation
module "workerK8S" {
  source              = "./modules/workerK8S"
  Public_SN_01_out_01 = module.vpcK8S.vpc01_public_subnet_01_id
  Public_SN_02_out_02 = module.vpcK8S.vpc01_public_subnet_02_id
  Public_SN_03_out_03 = module.vpcK8S.vpc01_public_subnet_03_id
  Public_SG_out       = [module.vpcK8S.vpc_public_sg]
  vpc_id_output       = module.vpcK8S.vpc_id

  eks_ep_out      = module.masterK8S.eks_cluster_endpoint
  eks_ca_data_out = module.masterK8S.eks_cluster_ca_data
  eks_sg_out      = module.masterK8S.eks_cluster_sg_01
}
