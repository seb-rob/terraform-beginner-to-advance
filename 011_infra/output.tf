
# prints output

output "aws_instance_ip" {
  value = aws_instance.aws_instance.public_ip
}

output "aws_instance_link" {
  value = "http://${aws_instance.aws_instance.public_ip}"
}