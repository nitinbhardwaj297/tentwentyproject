
# Hello World Web App on AWS

Deploys a simple "Hello World" web app on AWS using Terraform.

---

## Overview
- **Goal:** Automate infra and deploy Nginx web app.
- **Components:**
  - **VPC:** Public + private subnets
  - **EC2:** Hosts Nginx & HTML page
  - **ALB:** Routes HTTP traffic
  - **Security Groups:** Control access
  - **HTML Page:** Shows instance ID, AZ, and Nginx

---

## How It Works
1. **VPC & Subnets:** Public → ALB, Private → EC2  
2. **Security Groups:**  
   - ALB SG → HTTP (80) from anywhere  
   - EC2 SG → Only from ALB  
3. **EC2 Instances:** Nginx + custom HTML  
4. **ALB:** Routes traffic to healthy EC2s  
5. **Custom Page:** Accessible via ALB

---

## Prerequisites
- AWS account with VPC, EC2, ALB permissions  
- Terraform v1.5+  
- AWS CLI configured  
- Git  

---

## Project Structure
```
infra/
├── Makefile
├── provider.tf
├── vpc.tf
├── ec2.tf
├── alb.tf
├── terraform.tfstate
├── terraform.tfstate.backup
```

---

## Setup
```bash
git clone <repo-url>
cd infra
make init       # Initialize Terraform
make infra      # Deploy infra & app
```

- **Verify:** Open ALB DNS in browser → should see:
```
Hello World!
Instance ID: i-1234567890abcdef0
Availability Zone: us-east-1a
Served by: Nginx
```

- **Destroy infra:**
```bash
make destroy
```

---

## Useful Commands
| Command       | Description                   |
|---------------|-------------------------------|
| make init     | Initialize Terraform          |
| make infra    | Deploy infra & app            |
| make destroy  | Delete all resources          |
| make fmt      | Format Terraform code         |
| make validate | Validate Terraform config     |
