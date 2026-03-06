#############################################
# Terraform Variables
#############################################

# AWS region for this lab
variable "aws_region" {
  description = "AWS region to deploy infrastructure"
  type        = string
  default     = "us-east-1"
}

# Your public IP in CIDR format for SSH access
# Example: 203.0.113.10/32
variable "my_ip_cidr" {
  description = "Your public IP address in CIDR format for SSH access"
  type        = string

  validation {
    condition     = can(cidrhost(var.my_ip_cidr, 0))
    error_message = "The value must be a valid CIDR block (example: 203.0.113.10/32)."
  }
}
