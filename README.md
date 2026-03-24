Hello World Web App on AWS
Project Overview

This project demonstrates deploying a simple "Hello World" web application on AWS using Terraform and basic DevOps practices.

The main goal is to showcase:

Infrastructure automation using Terraform
Cloud networking and security practices
Deployment of a web application (Nginx) on EC2 instances
Load balancing with Application Load Balancer (ALB)

Key Components:

VPC with public and private subnets: Provides network isolation and secure deployment.
EC2 instances (private subnets): Hosts Nginx and serves a custom HTML page.
Application Load Balancer (public subnets): Routes HTTP traffic to EC2 instances.
Security groups: Ensures only allowed traffic reaches resources.
Custom HTML page: Displays instance details (ID, AZ, and Nginx).
How It Works
VPC & Subnets: Terraform creates a VPC with public and private subnets.
Public subnets host the ALB.
Private subnets host the EC2 instances.
Security Groups:
ALB SG: Allows HTTP traffic (port 80) from anywhere.
EC2 SG: Allows traffic only from ALB, no direct internet access.
EC2 Instances:
Launched in private subnets.
Nginx installed and configured with a simple HTML page.
Automatically registered with the ALB.
Application Load Balancer:
Routes traffic to EC2 instances.
Performs health checks to ensure traffic only goes to healthy instances.
Custom Page:
Served via Nginx on port 80.
Shows instance-specific information for easy verification.

Prerequisites

Before starting, ensure you have:

AWS account with permissions to create:
VPCs, subnets, route tables
Security groups
EC2 instances
ALB
Terraform installed (v1.5+ recommended)
AWS CLI configured with your access key and region
Git installed for cloning the repository

Project Structure

infra/
├── Makefile              # Commands to initialize, deploy, and destroy infrastructure
├── provider.tf           # Terraform provider configuration
├── vpc.tf                # VPC and subnet configuration
├── ec2.tf                # EC2 instance configuration
├── alb.tf                # ALB and listener configuration
├── terraform.tfstate     # Terraform state file
├── terraform.tfstate.backup

Explanation:

.tf files define infrastructure resources.
Makefile automates Terraform commands.
terraform.tfstate tracks the deployed resources.

Step 1: Clone the Repository

git clone <your-repo-url>
cd infra

Step 2: Initialize Terraform

make init
Initializes Terraform and downloads required providers.

Step 3: Create Infrastructure

make infra

This will:

Create VPC, subnets, route tables, and security groups
Launch EC2 instances with Nginx installed
Deploy the custom HTML page
Create an ALB with HTTP listener and health checks
Step 4: Verify Deployment
Get the ALB DNS name from AWS console or Terraform output.
Open the ALB URL in your browser.
You should see the page:

Hello World!
Instance ID: i-1234567890abcdef0
Availability Zone: us-east-1a
Served by: Nginx

Step 5: Destroy Infrastructure

make destroy

Deletes all AWS resources created by Terraform.

Nginx HTML Page

Terraform automatically provisions a custom page on EC2:

<!DOCTYPE html>
<html>
<head>
    <title>Hello World</title>
</head>
<body style="text-align: center; font-family: Arial; margin-top: 100px;">
    <h1>Hello World!</h1>
    <p>Instance ID: <strong>i-1234567890abcdef0</strong></p>
    <p>Availability Zone: <strong>us-east-1a</strong></p>
    <p>Served by: <strong>Nginx</strong></p>
</body>
</html>

Security Groups
Resource	Allowed Traffic
ALB SG	HTTP (port 80) from anywhere
EC2 SG	Only from ALB SG; no internet access
Useful Commands
Command	Description
make init	Initializes Terraform
make infra	Deploys all infrastructure and application
make destroy	Deletes all resources
make fmt	Formats Terraform code
make validate	Validates Terraform configuration
