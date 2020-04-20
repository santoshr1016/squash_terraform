# I want to create Multiple Resource Instances By Count

# Approach 1
# The count meta-argument accepts a whole number, and creates that many instances of the resource
resource "aws_instance" "rs_server_1" {
  count = 4 # create four similar EC2 instances

  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"

  tags = {
    Name = "Server ${count.index}"
  }
}


# Approach 2, Using the For each loop
variable "subnet_ids" {
  type = list(string)
  default = ["SN0", "SN1", "SN2", "SN3"]
}

resource "aws_instance" "rs_server_2" {
  # Create one instance for each subnet
  count = length(var.subnet_ids)

  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_ids[count.index]

  tags = {
    Name = "Server ${count.index}"
  }
}

output "print_server_1" {
  value = aws_instance.rs_server_2[0]
}

output "print_server_2" {
  value = aws_instance.rs_server_2[1]
  description = "You can write description about the variable."
}

output "print_server_3" {
  value = aws_instance.rs_server_2[2]
}

