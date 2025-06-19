variable "vm_list" {
  type = map(object({
    description       = string
    proxmox_node      = string
    cpu_cores         = number
    memory_dedicated  = number
    disk_size         = number
    datastore_id      = string
    tags              = list(string)
  }))
}
