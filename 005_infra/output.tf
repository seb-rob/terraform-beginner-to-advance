output "public_dns_of_instance" {
  value = aws_instance.mern-server-1.public_dns
}

output "public_ip_of_instance" {
  value = aws_instance.mern-server-1.public_ip
}