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

# Terraform Infrastructure Labs

This repository contains hands-on Terraform labs designed to demonstrate core Infrastructure-as-Code (IaC) and AWS networking concepts.

The goal is to build infrastructure progressively while following production best practices such as:

- version-controlled infrastructure
- CI validation
- security-first configuration
- modular cloud architecture

---

## Labs

### 1. AWS VPC Lab
Creates foundational networking infrastructure.

Components:
- VPC
- public subnet
- private subnet
- internet gateway
- route tables

Concepts demonstrated:
- CIDR planning
- subnet routing
- VPC architecture

Folder:

---

### 2. AWS Security Group Lab
Focuses on secure inbound access patterns.

Components:
- VPC networking
- SSH allowlisting
- HTTPS access
- least-privilege firewall rules

Concepts demonstrated:
- inbound vs outbound rules
- CIDR allowlists
- security group architecture

Folder:

---

### 3. AWS EC2 Lab
Deploys an EC2 instance using Terraform with dynamic infrastructure discovery.

Components:
- EC2 instance
- security group attachment
- public subnet placement

Concepts demonstrated:
- Terraform data sources
- dynamic AMI lookup
- availability zone discovery
- dependency graph reasoning

Folder:
---

## CI Validation

Terraform configurations are automatically validated via GitHub Actions.

Checks include:

- `terraform fmt`
- `terraform validate`
- provider initialization

This ensures all infrastructure definitions remain syntactically valid.

---

## Skills Demonstrated

Infrastructure as Code  
Terraform  
AWS Networking  
Cloud Security  
GitOps workflows  
CI validation pipelines
