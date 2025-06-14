#!/bin/bash

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8181:443
