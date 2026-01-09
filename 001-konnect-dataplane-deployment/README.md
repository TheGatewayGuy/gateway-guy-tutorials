# Tutorial 001: Manual Konnect Data Plane Deployment

This tutorial demonstrates how to manually deploy a Kong Gateway data plane that connects to Kong Konnect using a bash script and Helm.

## Video Tutorial

Watch the full video walkthrough of this tutorial on The Gateway Guy YouTube channel:

**[Watch on YouTube](https://www.youtube.com/watch?v=csTrbB0IG6c)**

Follow along with the video for detailed explanations and live demonstrations of each step.

## What This Tutorial Covers

This tutorial shows the manual approach to deploying a Kong data plane to Kubernetes, including:
- Creating a Kubernetes namespace for Kong
- Setting up TLS certificates for mTLS authentication with Konnect
- Deploying Kong Gateway data plane using Helm charts
- Configuring the data plane to connect to an existing Konnect control plane

## Prerequisites

Before running this tutorial, you need:
- A Kubernetes cluster with `kubectl` configured
- `helm` CLI installed
- An existing Kong Konnect control plane
- TLS certificates for cluster authentication (placed in `./certs/`)

## Files in This Tutorial

- `install.sh` - Bash script that automates the deployment
- `values.yaml` - Helm values file with Kong Gateway configuration
- `certs/tls.crt` - TLS certificate for mTLS authentication
- `certs/tls.key` - Private key for mTLS authentication

## How to Use

### Step 1: Prepare Certificates

Ensure your TLS certificates are placed in the `certs/` directory:
```bash
./certs/tls.crt
./certs/tls.key
```
These are generated within Konnect UI

### Step 2: Update Configuration

Edit `values.yaml` and update the following values to match your Konnect control plane:
- `cluster_control_plane` - Your control plane endpoint
- `cluster_server_name` - Your control plane server name
- `cluster_telemetry_endpoint` - Your telemetry endpoint
- `cluster_telemetry_server_name` - Your telemetry server name

You just need to replace `<prefix>` with the Konnect Control Plane prefix allocated 

### Step 3: Run the Installation Script

Execute the installation script:
```bash
chmod +x install.sh
./install.sh
```

This script will:
1. Create the `kong-demo` namespace
2. Create a Kubernetes secret with your TLS certificates
3. Add the Kong Helm repository
4. Deploy Kong Gateway data plane using Helm

### Step 4: Verify Deployment

Check the deployment status:
```bash
kubectl get pods -n kong-demo
```

Verify the data plane is connected in your Konnect dashboard.

## Cleanup

To remove the deployment:
```bash
helm uninstall kong -n kong-demo
kubectl delete namespace kong-demo
```