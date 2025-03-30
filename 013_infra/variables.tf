variable "aws_instance_type" {
  description = "What instance you wanna use for your instance?"
  type = string
  validation {
    condition = var.aws_instance_type == "t2.micro" || var.aws_instance_type == "t2.nano"
    error_message = "Only t2.micro and t2.nano allowed"
  }
}

variable "root_volume_size" {
  type = number
  default = 20
}

variable "root_volume_type" {
  type = string
  default = "gp2"
}

# This block replances above two variable block named root_volume_type & root_volume_size
variable "ec2_config" {
  type = object({
    volume_size = number
    volume_type = string
  })
  default = {
    volume_size = 20
    volume_type = "gp2"
  }
}


variable "additional_tags" {
  type = map(string)        # expecting key=value format
  default = {}
}

locals {
  delete_on_termination = true
  class = "some_class"
}