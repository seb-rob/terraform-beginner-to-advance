

# STATE MANIPULATION
    # list                List resources in the state
    # mv                  Move an item in the state
    # pull                Pull current state and output to stdout
    # push                Update remote state from a local state file
    # replace-provider    Replace provider in the state
    # rm                  Remove instances from the state
    # show                Show a resource in the state



# 2. terraform state mv
# Purpose: Moves an item in the state file. This is useful when you want to change the resource's address without modifying the actual infrastructure.
    # Scenario:
    # You have a resource aws_instance.old_instance, and you want to move it to a new name aws_instance.new_instance in the state without modifying the underlying infrastructure.

    # EXAMPLE
    # terraform state mv aws_instance.old_instance aws_instance.new_instance


# 3. terraform state pull
# Purpose: Pulls the current state from the remote backend and outputs it to standard output (stdout).
    # Scenario:
    # You want to fetch the current state from your remote backend (e.g., Terraform Cloud or an S3 bucket) and review it locally.

    # EXAMPLE
    # terraform state pull


# 4. terraform state push
# Purpose: Updates the remote state from a local state file.
    # Scenario:
    # You've made manual edits to the local state file and now you want to push those changes to the remote backend to synchronize it with the cloud.

    # EXAMPLE
    # terraform state push terraform.tfstate



# 5. terraform state replace-provider
# Purpose: Replaces the provider used for a resource in the state file.
    # Scenario:
    # Suppose you were using the aws provider but now want to switch to using a new aws provider with a different version or configuration.

    # EXAMPLE
    # terraform state replace-provider 'aws' 'new-provider'


# 6. terraform state rm
# Purpose: Removes resources from the state. It does not destroy the actual infrastructure but simply removes the resource from the Terraform state management.
    # Scenario:
    # You want to stop managing a resource with Terraform, for example, if you manually created a resource that was previously managed by Terraform.

    # EXAMPLE
    # terraform state rm aws_instance.example



# 7. terraform state show
# Purpose: Shows the details of a specific resource in the state file.
    # Scenario:
    # You want to see detailed information about a specific resource in the state, such as an EC2 instance, including its attributes and metadata.

    # EXAMPLE
    # terraform state show aws_instance.example
