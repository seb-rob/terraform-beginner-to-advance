
# CREATE VPC, SECURITY-GROUP, INSTALL NGINX, CREATE EC2 AND SO ON

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.91"
    }
  }
}