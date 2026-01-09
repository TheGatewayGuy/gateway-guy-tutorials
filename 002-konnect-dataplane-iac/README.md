# Tutorial 002: Konnect Data Plane Infrastructure as Code

This tutorial demonstrates how to provision and deploy a complete Kong Konnect control plane and data plane infrastructure using Terraform.

## Video Tutorial

Watch the full video walkthrough of this tutorial on The Gateway Guy YouTube channel:

**[Watch on YouTube](PLACEHOLDER_URL)**

Follow along with the video for detailed explanations and live demonstrations of each step.

## What This Tutorial Covers

This tutorial shows the Infrastructure as Code (IaC) approach to deploying Kong with Konnect, including:
- Creating a Konnect control plane via Terraform
- Automatically generating TLS certificates for mTLS authentication
- Provisioning a Kubernetes namespace
- Deploying Kong Gateway data plane using Helm via Terraform
- Registering the data plane certificate with the control plane

## Prerequisites

Before running this tutorial, you need:
- Terraform installed (v1.0+)
- A Kubernetes cluster with kubectl configured
- Kong Konnect account with system account access token
- Access to the Konnect API

## Files in This Tutorial

- `providers.tf` - Provider configurations (Konnect, Kubernetes, Helm, TLS)
- `variables.tf` - Input variables definitions
- `control_plane.tf` - Konnect control plane and certificate resources
- `data_plane.tf` - Kubernetes namespace and Helm deployment
- `certificate.tf` - TLS certificate generation resources
- `output.tf` - Output values from the deployment
- `env/demo.tfvars` - Example variable values

## How to Use

### Step 1: Configure Variables

Create a `terraform.tfvars` file or copy `env/demo.tfvars` and update with your values:

```hcl
konnect_system_account_access_token = "your-token-here"
konnect_org_region_url             = "https://eu.api.konghq.com"
gateway_name                       = "my-gateway"
cloud_gateway                      = false
environment                        = "dev"

labels = {
  team = "platform"
  env  = "dev"
}
```

### Step 2: Initialize Terraform

Initialize the Terraform working directory:
```bash
terraform init
```

### Step 3: Plan the Deployment

Review the planned changes:
```bash
terraform plan -var-file="env/demo.tfvars"
```

Or if using `terraform.tfvars`:
```bash
terraform plan
```

### Step 4: Apply the Configuration

Deploy the infrastructure:
```bash
terraform apply -var-file="env/demo.tfvars"
```

Or:
```bash
terraform apply
```

Type `yes` when prompted to confirm.

### Step 5: Verify Deployment

Check the Terraform outputs:
```bash
terraform output
```

Verify the resources:
```bash
kubectl get pods -n kong-demo
```

Check your Konnect dashboard to see the new control plane and connected data plane.

## Configuration Options

### Required Variables
- `konnect_system_account_access_token` - Your Konnect API token
- `gateway_name` - Name for your gateway control plane

### Optional Variables
- `konnect_org_region_url` - Konnect API region (default: EU)
- `cloud_gateway` - Whether to use cloud gateway (default: false)
- `environment` - Environment name: dev, uat, prev, prod (default: dev)
- `labels` - Map of labels to apply to resources
- `auth_type` - Certificate auth type (default: pinned_client_certs)
- `cluster_type` - Type of cluster (default: CLUSTER_TYPE_CONTROL_PLANE)

### TLS Certificate Options
- `tls_common_name` - Certificate common name (default: kong_clustering)
- `tls_validity_period_hours` - Certificate validity in hours (default: 26280 = 3 years)
- `key_algorithm` - Algorithm: RSA, ECDSA, ED25519 (default: ECDSA)
- `ecdsa_curve` - ECDSA curve: P224, P256, P384, P521 (default: P384)

## What Gets Created

This Terraform configuration creates:
1. A Konnect Gateway Control Plane
2. A self-signed TLS certificate for mTLS authentication
3. A Kubernetes namespace (`kong-demo`)
4. A registered data plane certificate in Konnect
5. A Helm deployment of Kong Gateway data plane

## Cleanup

To destroy all resources:
```bash
terraform destroy -var-file="env/demo.tfvars"
```

Or:
```bash
terraform destroy
```

Type `yes` when prompted to confirm.

## Advantages of This Approach

Compared to manual deployment:
- Fully automated and repeatable
- Version controlled infrastructure
- Automatic certificate generation and management
- Control plane is created as part of the deployment
- Easier to manage multiple environments
- Declarative configuration
