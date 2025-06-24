module "staging_proxmox_ubuntu_vms" {
  source = "../../modules/proxmox_ubuntu_vms"
  
  vm_list = var.vm_list_ubuntu

  public_keys = [var.PROXMOX_VM_PUBLIC_KEY]
}

module "staging_proxmox_haos_vms" {
  source = "../../modules/proxmox_home_assistant"
  
  vm_list = var.vm_list_haos
}
