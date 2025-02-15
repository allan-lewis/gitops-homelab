# Allan's GitOps Homelab

## Setup ArgoCD

### Prerequisites
1. A K8s cluster
1. <code>kubectl</code> installed and configured to manager the cluster above
1. An environment variable called DOPPLER_TOKEN set with a service token for a Doppler project/config 

### Bootstrap the k8s cluster

Run the command below to install ArgoCD into the k8s cluster.  This will enable ArgoCD to build Helm charts, and, finally, will manually create a secret containing a Doppler service token for later use with External Secrets. 

<code>./argocd/bootstrap-argo-cd.sh</code>

## Install ArgoCD Applications

### Applications

### Kustomizations