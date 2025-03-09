variable "vm_list" {
  type = map(object({
    description       = string
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
variable "public_keys" {}