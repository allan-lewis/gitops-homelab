# Allan's GitOps Homelab

## Setup ArgoCD

### Prerequisites
1. A K8s cluster
1. <code>kubectl</code> installed and configured to manager the cluster above
1. An environment variable called DOPPLER_TOKEN set with a service token for a Doppler project/config 

### Bootstrap the k8s cluster

Run the command below to install ArgoCD into the k8s cluster.  This will enable ArgoCD to build Helm charts, and, finally, will manually create a secret containing a Doppler service token for later use with External Secrets. 

```
./argocd/bootstrap-argo-cd.sh
```

## Install ArgoCD Applications

### Applications

Installing applications should be something done relatively infrequently, ideally just once following ArgoCD setup.  After that, ArgoCD will keep things up-to-date based on Git.

Applications are written as Kustomize manifests, for example:

```
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- ../base

patches:
- target:
    kind: Application
    name: .*
  patch: |-
    - op: replace
      path: /metadata/name
      value: nginx
    - op: add
      path: /spec/source/path
      value: kustomizations/boilerplate/environments/staging-nginx
    - op: add
      path: /spec/destination/namespace
      value: nginx
```

In order to install an application, run a Kustomize build and pipe the output to k8s.

```
kustomize build | kubectl apply -f -
```

### Kustomizations