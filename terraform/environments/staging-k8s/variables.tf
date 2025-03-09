variable "controlplane_list" {
  description = "A list of Talos Control Plane VMs to create"
  default = {
    alpha = {
      description       = "Talos Linux control plane node (managed by Terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 2
      memory_dedicated  = 2048
      datastore_id      = "local-lvm"
      disk_size         = 32
      ipv4_address      = "192.168.86.90"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "staging", "talos", "controlplane"]
    }
  }
}

variable "worker_list" {
  description = "A list of Talos Control Plane VMs to create"
  default = {
    beta = {
      description       = "Talos Linux worker node (managed by Terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 4
      memory_dedicated  = 8192
      datastore_id      = "local-lvm"
      disk_size         = 256
      ipv4_address      = "192.168.86.91"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "staging", "talos", "worker"]
    }
    gamma = {
      description       = "Talos Linux worker node (managed by Terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 4
      memory_dedicated  = 8192
      datastore_id      = "local-lvm"
      disk_size         = 256
      ipv4_address      = "192.168.86.92"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "staging", "talos", "worker"]
    }
    # delta = {
    #   description       = "Talos Linux worker node /w OpenVPN gateway (managed by Terraform)"
    #   proxmox_node      = "polaris"
    #   cpu_cores         = 2
    #   memory_dedicated  = 4096
    #   datastore_id      = "local-lvm"
    #   disk_size         = 64
    #   ipv4_address      = "192.168.86.93"
    #   gateway           = "192.168.86.123"
    #   tags              = ["terraform", "staging", "talos", "worker"]
    # }
  }
}

# Set this from an environment variable called TF_VAR_PROXMOX_VM_PUBLIC_KEY
variable "PROXMOX_VM_PUBLIC_KEY" {}
