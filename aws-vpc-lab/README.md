# AWS VPC Lab (Terraform) — Public + Private Subnet (No NAT)

## What this lab builds
This Terraform lab creates a minimal AWS networking foundation:

- 1 VPC (`10.0.0.0/16`)
- 1 Public Subnet (`10.0.1.0/24`)
- 1 Private Subnet (`10.0.2.0/24`)
- 1 Internet Gateway (IGW)
- 1 Public Route Table with `0.0.0.0/0 → IGW`
- Route table association for the public subnet

## Why no NAT Gateway?
NAT Gateway is intentionally excluded to avoid costs during early learning.  
Without NAT, the private subnet has **no outbound internet access**, which reinforces the concept of private routing.

In production, NAT (or VPC endpoints) would be added if private workloads need outbound access (e.g., package updates, container pulls, external APIs).

## Architecture (conceptual)
Internet
  |
 [IGW]
  |
Public Subnet (10.0.1.0/24)  ---> outbound/inbound (controlled by SG)
Private Subnet (10.0.2.0/24) ---> no direct internet route

## Prerequisites
- Terraform installed
- AWS CLI configured (IAM user, not root)
- Region: `us-east-1`

## Commands

### Initialize
terraform init

### Preview changes
terraform plan

### Create resources
terraform apply

### Destroy resources (important hygiene)
terraform destroy

## What I learned / reinforced
- CIDR basics (/16 vs /24)
- Public vs private subnets are defined by routing (IGW vs no IGW), not security groups
- Terraform lifecycle discipline (apply + destroy)
