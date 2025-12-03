# Konnect Dataplane deployment
This tutorial is to deploy a Konnect data plane manually

It used to support this YouTube video: https://www.youtube.com/watch?v=csTrbB0IG6c

## Pre-reqs
1. Register for a Konnect account: https://cloud.konghq.com
2. Install kind: https://kind.sigs.k8s.io/
3. Install k9s: https://k9scli.io/
4. Install helm: https://helm.sh/docs/intro/install/

## Deployment
Follow the YouTube video to setup your control plane and certificates then
1. Copy your cert and key into the `cert` folder from Konnect
2. Copy your `values.yaml` from Konnect and paste into `values.yaml`
3. Create a new cluster
`kind create cluster`
4. Run `bash install.sh`
