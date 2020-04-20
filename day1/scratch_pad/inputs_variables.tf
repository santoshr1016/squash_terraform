variable "image_id" {
  type = string
}

# Input Variable Documentation
variable "image_id_with_description" {
  type = string
  description = "The id of the machine image (AMI) to use for the server."
}

# Custom validation rules
variable "image_id_with_validation" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  # See the conditions
  validation = {
    #condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    condition     = can(regex("^ami-", var.image_id))
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "azs" {
  type = list(string)
  default = ["us-east-1a"]
}

# Object can take different data type
# Types are string, number, bool
/*
list(<TYPE>)
set(<TYPE>)
map(<TYPE>)
object({<ATTR NAME> = <TYPE>, ... })
tuple([<TYPE>, ...])
*/
variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))

  default = [
    {
      internal = 80
      external = 9090
      protocol = "TCP"
    }
  ]
}
