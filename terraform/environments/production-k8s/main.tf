module "production_proxmox_talos_cluster" {
  source = "../../modules/proxmox_talos_cluster"
  
  controlplane_list = var.controlplane_list
  
  worker_list = var.worker_list

  cluster_name = "k8s-production"

  node_name = "sirius"
}

output "talosconfig" {
  value = module.production_proxmox_talos_cluster.talosconfig
  sensitive = true
}

output "kubeconfig" {
  value = module.production_proxmox_talos_cluster.kubeconfig
  sensitive = true
}
