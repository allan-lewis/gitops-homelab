terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.84.0"
    }
  }
}

module "staging_proxmox_talos_cluster" {
  source = "../../modules/proxmox_talos_cluster"
  
  controlplane_list = var.controlplane_list
  
  worker_list = var.worker_list

  cluster_name = "k8s-staging"

  node_name = "polaris"
}

# default config to satisfy anything that expects an unaliased provider
provider "proxmox" {
  endpoint = var.PROXMOX_VE_ENDPOINT_POLARIS
  username = "root@pam"
  password = var.PROXMOX_VE_PASSWORD_POLARIS
  insecure = false   # or true if you must skip TLS validation
}

output "talosconfig" {
  value = module.staging_proxmox_talos_cluster.talosconfig
  sensitive = true
}

output "kubeconfig" {
  value = module.staging_proxmox_talos_cluster.kubeconfig
  sensitive = true
}
