

# TERRAFORM INPORT COMMAND

# ===============================================================

# The terraform import command is used to bring existing infrastructure under Terraform management. It allows you to import resources that were manually created or managed outside of Terraform into your Terraform state, so that Terraform can track, manage, and update these resources going forward.

# ===============================================================

# Example 1: Import an AWS EC2 Instance
# Let's say you have an existing EC2 instance in AWS with the ID i-0abcd1234efgh5678, and you want to start managing it using Terraform.

# terraform command: 
# terraform import aws_instance.example i-0abcd1234efgh5678

# ===============================================================

# Example 2: Import an AWS S3 Bucket
# Suppose you have an existing S3 bucket named my-existing-bucket, and you want to import it into your Terraform configuration.

# terraform command: 
# terraform import aws_s3_bucket.my_bucket my-existing-bucket

# ===============================================================