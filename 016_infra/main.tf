
# OPERATORS AND EXPRESSIONS IN TERRAFORM

terraform {}


# number list
variable "num_list" {
  type = list(number)
  default = [ 1, 2, 3, 4, 5, 6 ]        
}


# object list of persons
variable "person_list" {
  type = list(object({
    fname = string
    lname = string
  }))
  default = [ {
    fname = "Raju"
    lname = "Rastogi"
  },
  {
    fname = "Farhan"
    lname = "Lization"
  } ]
}


# map
variable "map_list" {
  type = map(number)
  default = {
    "one" = 1
    "two" = 2
    "three" = 3
  }
}


# calculations
locals {
  mul = 2 * 2
  add = 2 + 2
  eq = 2 != 3

  # double num_list variable
  double = [for num in var.num_list: num * 2]

  # odd number from num_list variable
  odd = [for num in var.num_list: num if num % 2 != 0]

  # get first name from person_list
  fname = [for person in var.person_list: person.fname]

  # get last name from person_list
  lname = [for person in var.person_list: person.lname]

  # work with map get keys from map_list
  get_keys = [for key, value in var.map_list: key]

  # work with map get values from map_lsit
  get_values = [for key, value in var.map_list: value]

  # work with map double values of map_list
  double_map_values = {for key, value in var.map_list: key => value * 2}
}

# print output and test
output "output" {
  value = local.double_map_values
}