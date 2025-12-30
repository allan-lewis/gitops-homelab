terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.90.0"
    }
  }
}

module "production_proxmox_talos_cluster" {
  source = "../../modules/proxmox_talos_cluster"
  
  controlplane_list = var.controlplane_list
  
  worker_list = var.worker_list

  cluster_name = "k8s-production"

  node_name = "sirius"
}

# default config to satisfy anything that expects an unaliased provider
provider "proxmox" {
  endpoint = var.PROXMOX_VE_ENDPOINT_SIRIUS
  username = "root@pam"
  password = var.PROXMOX_VE_PASSWORD_SIRIUS
  insecure = false   # or true if you must skip TLS validation
}

output "talosconfig" {
  value = module.production_proxmox_talos_cluster.talosconfig
  sensitive = true
}

output "kubeconfig" {
  value = module.production_proxmox_talos_cluster.kubeconfig
  sensitive = true
}
