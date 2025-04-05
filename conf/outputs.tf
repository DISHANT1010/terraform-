output "ec2_public_ip" {
  value = [
    for ip in aws_instance.terraform-instance : ip.public_ip
  ]
}

output "ec2_private_ip" {
  value = [
    for pip in aws_instance.terraform-instance : pip.private_ip
  ]
}

output "ec2_public_dns" {
  value = [
    for dns in aws_instance.terraform-instance : dns.public_dns
  ]
}