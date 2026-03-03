# infra-labs

A structured collection of infrastructure labs focused on building cloud-native / AI-infrastructure engineering skills.

## Goals
- Build strong cloud networking fundamentals (VPC, routing, security boundaries)
- Learn Infrastructure as Code with Terraform
- Progress toward Kubernetes (EKS) and ML/AI infrastructure patterns

## Labs
### 1) aws-vpc-lab
Terraform lab that creates:
- VPC (10.0.0.0/16)
- Public + private subnet
- Internet Gateway + public route table
- No NAT Gateway (cost-controlled learning lab)

## How to use
Each lab folder contains its own README with:
- What it builds
- Why the design choices were made
- How to apply/destroy safely
