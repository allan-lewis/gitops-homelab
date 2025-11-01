#!/bin/bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_MAP="$SCRIPT_DIR/argocd-config-map.yaml"

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

kubectl create secret generic doppler-token --from-literal dopplerToken=$DOPPLER_TOKEN --dry-run=client -o yaml | kubectl apply -f -

doppler run --command "envsubst < argocd-helm-values-template.yaml > /tmp/argocd-values.yaml"

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

helm install argocd argo/argo-cd -n argocd --create-namespace --version 9.0.5 -f /tmp/argocd-values.yaml

kubectl apply -f $CONFIG_MAP

# helm upgrade argocd argo/argo-cd --namespace argocd --version 7.9.1 -f /tmp/argocd-values.yaml
# helm upgrade argocd argo/argo-cd --namespace argocd --version 8.5.6 -f /tmp/argocd-values.yaml
# kubectl rollout restart deployment argocd-server -n argocd
# kubectl rollout restart deployment argocd-dex-server -n argocd
