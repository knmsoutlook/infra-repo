## Infra Repo – EC2 + Docker via Terraform

### Prerequisites
- AWS account
- Existing EC2 Key Pair
- GitHub OIDC IAM role: **GitHub Actions Terraform role**

### Repo Variables
- `TF_VAR_key_name` = your EC2 key pair name
- `TF_VAR_my_ip_cidr` = YOUR_PUBLIC_IP/32

### Steps
1. Update `.github/workflows/terraform.yml` with your AWS account ID.
2. Push to `main`.
3. GitHub Actions provisions EC2.
4. Copy `EC2_PUBLIC_IP` from Terraform output.

### Verify
```bash
ssh ubuntu@EC2_PUBLIC_IP
docker --version
docker compose version