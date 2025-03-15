module "staging_proxmox_talos_cluster" {
  source = "../../modules/proxmox_talos_cluster"
  
  controlplane_list = var.controlplane_list
  
  worker_list = var.worker_list

  cluster_name = "k8s-staging"

  node_name = "polaris"
}

output "talosconfig" {
  value = module.staging_proxmox_talos_cluster.talosconfig
  sensitive = true
}

output "kubeconfig" {
  value = module.staging_proxmox_talos_cluster.kubeconfig
  sensitive = true
}
