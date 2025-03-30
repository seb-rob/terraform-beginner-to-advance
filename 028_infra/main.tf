

# PRE ADN POST CONDITIONS - RESOURCE VALIDATION
# 1. Preconditions:
# Preconditions are conditions that must be satisfied before Terraform can create, update, or delete a resource.
# If the precondition is not met, Terraform will fail with an error.
# Preconditions are useful for enforcing rules that must be true before any changes are applied.

# 2. Postconditions:
# Postconditions are conditions that must be true after Terraform applies changes.
# If the postcondition is not satisfied, Terraform will fail after applying the plan and the resource will be reverted back to its original state.
# Postconditions are useful to verify that resources are correctly configured after Terraform has applied changes.


resource "aws_instance" "example" {
  ami           = "ami-076c6dbba59aa92e6"
  instance_type = "t2.micro"

  lifecycle {
    # Precondition: Ensure that the instance type is not empty
    precondition {
      condition = length(var.instance_type) > 0
      error_message = "Instance type must not be empty."
    }

    # Postcondition: Ensure that the instance is running
    postcondition {
      condition = aws_instance.example.state == "running"
      error_message = "The EC2 instance should be in the 'running' state after creation."
    }
  }
}

