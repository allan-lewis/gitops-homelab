variable "controlplane_list" {
  type = map(object({
    vm_name           = string
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

variable "worker_list" {
  type = map(object({
    vm_name           = string
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

variable "cluster_name" {}