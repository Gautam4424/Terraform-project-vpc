# Terraform Project for AWS Infrastructure

This repository contains Terraform configurations to set up a basic AWS infrastructure with a VPC, subnets, an internet gateway, a route table, and a public EC2 instance running NGINX.

## Project Structure

```
|-- main.tf
|-- variables.tf  # (if any variables are defined)
|-- outputs.tf    # (if any outputs are defined)
|-- .gitignore
|-- README.md
```

## Resources Created

### VPC
- CIDR Block: `10.0.0.0/16`
- Name Tag: `my-vpc`

### Subnets
1. **Public Subnet**
   - CIDR Block: `10.0.1.0/24`
   - Availability Zone: `ap-south-1a`
   - Name Tag: `public`

2. **Private Subnet**
   - CIDR Block: `10.0.2.0/24`
   - Availability Zone: `ap-south-1a`
   - Name Tag: `private`

### Internet Gateway
- Name Tag: `my-igw`

### Route Table
- Routes:
  - Destination: `0.0.0.0/0`
  - Target: Internet Gateway
- Name Tag: `MY-RT`

### EC2 Instance
- AMI: `ami-053b12d3152c0cc71`
- Instance Type: `t2.micro`
- Subnet: Public Subnet
- Security Group: Custom Security Group
- NGINX installed and started via `user_data`.

## Prerequisites

- Terraform installed on your local machine.
- AWS CLI installed and configured with appropriate permissions.
- An AWS account.

## Usage

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Plan the Infrastructure**
   ```bash
   terraform plan
   ```

3. **Apply the Configuration**
   ```bash
   terraform apply
   ```

   Type `yes` to confirm.

4. **Destroy the Infrastructure** (if needed)
   ```bash
   terraform destroy
   ```

## Notes

- Ensure the region in the `provider` block matches your desired AWS region.
- Update the AMI ID as per your region.