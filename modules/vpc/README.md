# module: vpc

Reusable parameterized Terraform module for VPC and subnets with IGW, NAT Gateway, and route tables

## Usage

```hcl
module "vpc" {
  source = "git::https://github.com/AnandJoy7/terraform-vpc-module.git//modules/vpc?ref=main"
}
```
