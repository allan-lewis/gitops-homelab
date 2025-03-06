# variable vm_name {}
# variable proxmox_node {}
# variable cpu_cores {}
# variable memory_dedicated {}
# variable ipv4_address {}
# variable gateway {}
# variable datastore_id {}
# variable disk_size {}
# variable tags {}
# variable user_account_keys {}
variable "vm_list" {
  type = map(object({
    vm_name           = string
    proxmox_node      = string
    cpu_cores         = number
    memory_dedicated  = number
    disk_size         = number
    ipv4_address      = string
    gateway           = string
    datastore_id      = string
    tags              = list(string)
  }))
}
# Set this from an environment variable called TF_VAR_PROXMOX_VM_PUBLIC_KEY
variable "PROXMOX_VM_PUBLIC_KEY" {}