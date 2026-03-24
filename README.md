# Hello World Web App on AWS

## Project Overview

This project demonstrates deploying a simple "Hello World" web application on **AWS** using Terraform and basic DevOps practices. The architecture includes:

- **VPC** with public and private subnets  
- **EC2 instances** running Nginx in private subnets  
- **Application Load Balancer (ALB)** in public subnets  
- Proper **security groups** and routing  
- A custom HTML page showing instance details  

This project showcases your understanding of cloud networking, infrastructure automation, and application deployment.

---

## Architecture Diagram
  Internet
     |
     v
     +-----------------+
| ALB (Public) |
+-----------------+
| |
v v
+-------------+ +-------------+
| EC2 Private | | EC2 Private |
| Instance 1 | | Instance 2 |
+-------------+ +-------------+
| |
Private Subnets
|
VPC


- **ALB:** Routes traffic to private EC2 instances  
- **EC2:** Hosts Nginx and custom HTML page  
- **Security:** ALB accepts HTTP from anywhere; EC2 only accepts traffic from ALB  

---

## Prerequisites

Before running this project, make sure you have:

1. **AWS Account** with permissions to create:
   - VPCs, subnets, route tables  
   - Security groups  
   - EC2 instances  
   - Application Load Balancer  
2. **Terraform installed** (v1.5+ recommended)  
3. **AWS CLI configured** with your access key and region  

---

## Project Structure
infra/
├── Makefile
├── provider.tf
├── vpc.tf
├── ec2.tf
├── alb.tf
├── terraform.tfstate
├── terraform.tfstate.backup


- `Makefile` – automation commands to init, create, destroy infra  
- `*.tf` files – Terraform configurations for network, EC2, ALB  

---

## Setup Tutorial

### Step 1: Clone the repository

```bash
git clone <your-repo-url>
cd infra

Step 2: Initialize Terraform

make init
This will initialize Terraform in the current directory.

Step 3: Create Infrastructure

make infra

This will:

Create the VPC, subnets, route tables, security groups
Launch EC2 instances
Deploy Nginx and the custom HTML page
Create ALB with HTTP listener and health checks
Step 4: Verify Deployment
Get the ALB DNS name from the AWS console or Terraform output
Open it in a browser to see your page:

Sample Page Output:

Hello World!
Instance ID: i-1234567890abcdef0
Availability Zone: us-east-1a
Served by: Nginx

Step 5: Destroy Infrastructure

make destroy

This will remove all AWS resources created by Terraform.

Security Groups
ALB SG: HTTP (port 80) from anywhere
EC2 SG: Only allow traffic from ALB SG; no direct internet access
Nginx Configuration

Terraform provisions Nginx on EC2 instances with a simple HTML page:

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

This page is served on port 80 via Nginx.

Notes / Tips
Make sure Terraform state files (terraform.tfstate) are in the same folder as .tf files
For multiple availability zones, modify the subnet and EC2 configuration in ec2.tf
You can format and validate Terraform config:

make fmt
make validate

#![alt text](image-1.png)
#![alt text](image-1.png)

