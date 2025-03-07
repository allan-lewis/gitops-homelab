module "staging_proxmox_ubuntu_vms" {
  source = "../../modules/proxmox_ubuntu_vms"
  
  vm_list = var.vm_list_ubuntu

  public_keys = [var.PROXMOX_VM_PUBLIC_KEY]
}

module "staging_proxmox_talos_cluster" {
  source = "../../modules/proxmox_talos_cluster"
  
  controlplane_list = var.controlplane_list
  
  worker_list = var.worker_list

  cluster_name = "staging"
}

# output "talosconfig" {
#   value = module.staging_proxmox_talos_cluster.talosconfig
#   sensitive = true
# }

# output "kubeconfig" {
#   value = module.staging_proxmox_talos_cluster.kubeconfig
#   sensitive = true
# }
