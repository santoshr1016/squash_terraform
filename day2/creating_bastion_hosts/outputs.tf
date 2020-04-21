# Outputs.tf
output "out_instance_id" {
  description = " Instance ID of the instance"
  value       = aws_instance.var_ec2_instance.id
}

output "out_instance_IP" {
  description = " Public IP of the instance"
  value       = aws_instance.var_ec2_instance.public_ip
}

/*

# See the usage of * operation here to get ip of all the ec2 machine
output "out_instance_ip" {
  value = aws_instance.var_ec2_instance.*.public_ip
  description = "Public ip of the instances"
}

# here element operator gives me index specific ec2 instance
output "out_instance_idd" {
  value = "Instance id : ${element(aws_instance.var_ec2_instance.*.id, 0)}}"
}

*/