module "staging_ubuntu_vms" {
  source = "../../modules/vm_ubuntu"
  
  vm_list = var.vm_list_ubuntu

  PROXMOX_VM_PUBLIC_KEY = var.PROXMOX_VM_PUBLIC_KEY
}

module "staging_talos_vms" {
  source = "../../modules/vm_talos"
  
  # vm_list = var.vm_list_ubuntu

  # PROXMOX_VM_PUBLIC_KEY = var.PROXMOX_VM_PUBLIC_KEY
}
