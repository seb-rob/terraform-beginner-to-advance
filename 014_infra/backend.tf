terraform {
    backend "s3" {
        bucket = "sonam-basket-4e3bc241"
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}
