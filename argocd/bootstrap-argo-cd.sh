#!/bin/bash

kubectl apply -f namespace.yaml

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.14.2/manifests/install.yaml

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

kubectl port-forward svc/argocd-server -n argocd 8181:443
