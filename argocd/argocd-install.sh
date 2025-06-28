#!/bin/bash

set -eu

doppler run --command "envsubst < values.yaml > /tmp/argocd-values.yaml"

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

helm install argocd argo/argo-cd -n argocd --create-namespace -f /tmp/argocd-values.yaml

# helm upgrade argocd argo/argo-cd --namespace argocd --version 7.9.1 -f /tmp/argocd-values.yaml
# kubectl rollout restart deployment argocd-server -n argocd
# kubectl rollout restart deployment argocd-dex-server -n argocd
