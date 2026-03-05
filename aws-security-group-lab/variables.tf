#############################################
# Variables (Level 1)
#############################################

# AWS region to deploy into (kept simple for now)
variable "aws_region" {
  description = "AWS region for this lab"
  type        = string
  default     = "us-east-1"
}

# Your public IP in CIDR format for SSH allowlisting
# Example: "203.0.113.10/32"
variable "my_ip_cidr" {
  description = "Your public IP in CIDR format for SSH access (x.x.x.x/32)"
  type        = string
}
