#############################################
# Terraform Outputs
#############################################

# Output the VPC ID after Terraform runs
output "vpc_id" {
  description = "ID of the VPC created in this lab"
  value       = aws_vpc.lab_vpc.id
}

# Output the public subnet ID
output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

# Output the security group ID
output "security_group_id" {
  description = "ID of the web admin security group"
  value       = aws_security_group.web_admin_sg.id
}
