#!/bin/bash

kubectl create namespace kong-demo
kubectl create secret tls kong-cluster-cert -n kong-demo --cert=./certs/tls.crt --key=./certs/tls.key

helm repo add kong https://charts.konghq.com
helm repo update
helm install kong kong/kong -n kong-demo --skip-crds --values ./values.yaml