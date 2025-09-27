variable "controlplane_list" {
  description = "A list of Talos Control Plane VMs to create"
  default = {
    roland = {
      description       = "Talos Linux control plane node (managed by Terraform)"
      proxmox_node      = "sirius"
      cpu_cores         = 4
      memory_dedicated  = 8192
      datastore_id      = "ssd0"
      disk_size         = 128
      ipv4_address      = "192.168.86.230"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "production", "talos", "controlplane"]
    }
  }
}

variable "worker_list" {
  description = "A list of Talos Control Plane VMs to create"
  default = {
    eddie = {
      description       = "Talos Linux worker node (managed by Terraform)"
      proxmox_node      = "sirius"
      cpu_cores         = 4
      memory_dedicated  = 12288
      datastore_id      = "ssd0"
      disk_size         = 640
      ipv4_address      = "192.168.86.234"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "production", "talos", "worker"]
    }
    jake = {
      description       = "Talos Linux worker node (managed by Terraform)"
      proxmox_node      = "sirius"
      cpu_cores         = 4
      memory_dedicated  = 12288
      datastore_id      = "ssd0"
      disk_size         = 640
      ipv4_address      = "192.168.86.235"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "production", "talos", "worker"]
    }
    susannah = {
      description       = "Talos Linux worker node (managed by Terraform)"
      proxmox_node      = "sirius"
      cpu_cores         = 4
      memory_dedicated  = 8192
      datastore_id      = "ssd0"
      disk_size         = 128
      ipv4_address      = "192.168.86.236"
      gateway           = "192.168.86.123"
      tags              = ["terraform", "production", "talos", "worker"]
    }
  }
}

# Set this from an environment variable called TF_VAR_PROXMOX_VM_PUBLIC_KEY
variable "PROXMOX_VM_PUBLIC_KEY" {}
