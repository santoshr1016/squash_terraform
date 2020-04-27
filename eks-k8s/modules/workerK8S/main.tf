#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EC2 Security Group to allow networking traffic
#  * Data source to fetch latest EKS worker AMI
#  * AutoScaling Launch Configuration to configure worker instances
#  * AutoScaling Group to launch worker instances
#
# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  torus-cluster-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${var.eks_ep_out}' --b64-cluster-ca '${var.eks_ca_data_out}' '${var.EKS_Cluster_Name}'
USERDATA
}

### EKS-Node-Create-Role-And-Instance-Profile

resource "aws_iam_role" "worker-node-role" {
  name = "${var.EKS_Cluster_Name}-worker"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "worker-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.worker-node-role.name
}

resource "aws_iam_role_policy_attachment" "worker-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.worker-node-role.name
}

resource "aws_iam_role_policy_attachment" "worker-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.worker-node-role.name
}

resource "aws_iam_instance_profile" "EKSInstanceProfile" {
  name = var.EKS_Cluster_Name
  role = aws_iam_role.worker-node-role.name
}

### EKS-Node-Security-Groups
resource "aws_security_group" "WorkerNodeSG01" {
  name        = "${var.EKS_Cluster_Name}-node"
  description = "Security Group For All Nodes In Cluster"
  vpc_id      = var.vpc_id_output

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = map(
  "Name", "${var.EKS_Cluster_Name}-node",
  "kubernetes.io/cluster/${var.EKS_Cluster_Name}", "owned",
  )
}

resource "aws_security_group_rule" "eks-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.WorkerNodeSG01.id
  source_security_group_id = aws_security_group.WorkerNodeSG01.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.WorkerNodeSG01.id
  source_security_group_id = var.eks_sg_out
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-cluster-ingress-node-https" {
  description              = "Allow Pods To Communicate With Cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = var.eks_sg_out
  source_security_group_id = aws_security_group.WorkerNodeSG01.id
  to_port                  = 443
  type                     = "ingress"
}

### The ami are defined in the variables, TODO
//data "aws_ami" "eks-worker" {
//  filter {
//    name   = "name"
//    values = ["amazon-eks-node-${aws_eks_cluster.test.version}-v*"]
//  }
//
//  most_recent = true
//  owners      = ["602401143452"] # Amazon EKS AMI Account ID
//}

### EKS-Launch-Configuration
############################################################################
resource "aws_launch_configuration" "eks_node_lc" {
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.EKSInstanceProfile.name
//  image_id                    = "${data.aws_ami.eks-worker.id}"
  image_id                    = lookup(var.ami, var.region)
  instance_type               = "t2.xlarge"
  name_prefix                 = var.EKS_Cluster_Name
  security_groups             = [aws_security_group.WorkerNodeSG01.id]
  user_data_base64            = base64encode(local.torus-cluster-node-userdata)

  lifecycle {
    create_before_destroy = true
  }
}

### EKS-Auto-Scaling-Group
############################################################################
resource "aws_autoscaling_group" "eks_nodes_asg" {
  desired_capacity     = 4
  launch_configuration = aws_launch_configuration.eks_node_lc.id
  max_size             = 6
  min_size             = 4
  name                 = var.EKS_Cluster_Name
  vpc_zone_identifier  = [var.Public_SN_01_out_01,var.Public_SN_02_out_02,var.Public_SN_03_out_03]

  tags = [
    {
    key                 = "Name"
    value               = var.EKS_Cluster_Name
    propagate_at_launch = true
    },
    {
    key                 = "kubernetes.io/cluster/${var.EKS_Cluster_Name}"
    value               = "owned"
    propagate_at_launch = true
    },]
}
