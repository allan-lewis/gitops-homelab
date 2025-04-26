variable "controlplane_list" {
  description = "A list of Talos Control Plane VMs to create"
  default = {
    bellatrix = {
      description       = "Talos Linux control plane node (managed by Terraform)"
      proxmox_node      = "sirius"
      cpu_cores         = 4
      memory_dedicated  = 4096
      datastore_id      = "local-lvm"
      disk_size         = 64
      ipv4_address      = "192.168.86.150"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "production", "talos", "controlplane"]
    }
  }
}

variable "worker_list" {
  description = "A list of Talos Control Plane VMs to create"
  default = {
    alnilam = {
      description       = "Talos Linux worker node (managed by Terraform)"
      proxmox_node      = "sirius"
      cpu_cores         = 4
      memory_dedicated  = 8192
      datastore_id      = "local-lvm"
      disk_size         = 256
      ipv4_address      = "192.168.86.151"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "production", "talos", "worker"]
    }
  }
}

# Set this from an environment variable called TF_VAR_PROXMOX_VM_PUBLIC_KEY
variable "PROXMOX_VM_PUBLIC_KEY" {}
