#!/bin/bash

if [ -z "$DOPPLER_TOKEN" ]; then
  echo "DOPPLER_TOKEN is not set; exiting"
  exit 1
fi

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

kubectl create secret generic doppler-token --from-literal dopplerToken=$DOPPLER_TOKEN --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.14.2/manifests/install.yaml

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

kubectl port-forward svc/argocd-server -n argocd 8181:443
