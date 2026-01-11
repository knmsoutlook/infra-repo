output "EC2_PUBLIC_IP" {
  value = aws_instance.app.public_ip
}

output "SSH_COMMAND" {
  value = "ssh ubuntu@${aws_instance.app.public_ip}"
}