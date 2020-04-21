# Outputs.tf
output "out_instance_id" {
  description = " Instance ID of the instance"
  value       = aws_instance.var_ec2_instance.id
}

output "out_instance_IP" {
  description = " Public IP of the instance"
  value       = aws_instance.var_ec2_instance.public_ip
}

