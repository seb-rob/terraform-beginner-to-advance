
# creates ec2 and installs nginx to it

resource "aws_instance" "aws_instance" {
  ami = "ami-05c179eced2eb9b5b"
  instance_type = "t2.micro"
  # associate_public_ip_address = true
  subnet_id = aws_subnet.aws_subnet_public.id
  vpc_security_group_ids = [aws_security_group.aws_security_group.id]
  
  tags = {
    Name = "aws_instance"
  }

  # user_data = <<-EOF
  #   #!/bin/bash
  #   sudo yum update -y
  #   sudo yum install -y nginx
  #   sudo systemctl start nginx
  #   sudo systemctl enable nginx
  # EOF
}


# │ Error: creating EC2 Instance: operation error EC2: RunInstances, https response error StatusCode: 400, RequestID: bb46f125-b2f3-4b44-b641-ecd75a35f205, api error InvalidGroup.NotFound: The security group 'terraform-20250320171758431200000001' does not exist in VPC 'vpc-0998ae8e5a0522c7d'
# │
# │   with aws_instance.aws_instance,
# │   on ec2.tf line 4, in resource "aws_instance" "aws_instance":
# │    4: resource "aws_instance" "aws_instance" {
