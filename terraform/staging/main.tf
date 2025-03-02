module "devops" {
  source = "../modules/vm_ubuntu"
  vm_name = "procyon"
  proxmox_node = "polaris"
  cpu_cores = 2
  memory_dedicated = 2048
  datastore_id = "local-ssd"
  disk_size = 64
  ipv4_address = "192.168.86.125/24"
  tags = ["terraform", "production", "ubuntu", "devops"]
  user_account_keys = [var.PROXMOX_VM_PUBLIC_KEY]
}

# Set this from an environment variable called TF_VAR_PROXMOX_VM_PUBLIC_KEY
variable "PROXMOX_VM_PUBLIC_KEY" {}
