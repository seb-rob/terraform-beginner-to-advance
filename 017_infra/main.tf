
# FUNCTIONS IN TERRAFORM

terraform {}

locals {
  value = "Hello World!"
}

variable "string_list" {
  type = list(string)
  default = [ "serv1", "serv2", "serv3", "serv1" ]
}

output "output" {
    # value = lower(local.value)
    # value = upper(local.value)
    # value = startswith(local.value, "He")
    # value = endswith(local.value, "ld!")
    # value = split(" ", local.value)
    # value = join(" ", var.string_list)
    # value = max(1, 3, 2, 5)
    # value = min(1, 34, 2, 4, 0)
    # value = abs(-13.34)
    # value = length(var.string_list)
    value = toset(var.string_list)
}