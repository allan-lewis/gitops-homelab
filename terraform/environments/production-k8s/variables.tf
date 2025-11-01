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
      ipv4_address      = "192.168.86.151"
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
      ipv4_address      = "192.168.86.152"
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
      ipv4_address      = "192.168.86.153"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "production", "talos", "worker"]
    }
    susannah = {
      description       = "Talos Linux worker node (managed by Terraform)"
      proxmox_node      = "sirius"
      cpu_cores         = 4
      memory_dedicated  = 12288
      datastore_id      = "ssd0"
      disk_size         = 640
      ipv4_address      = "192.168.86.154"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "production", "talos", "worker"]
    }
  }
}

# Set this from an environment variable called TF_VAR_PROXMOX_VM_PUBLIC_KEY
variable "PROXMOX_VM_PUBLIC_KEY" {}

# Proxmox endpoints for each cluster (filled via TF_VAR_* or tfvars)
variable "PROXMOX_VE_ENDPOINT_SIRIUS" {
  type        = string
  description = "API endpoint for the Sirius Proxmox cluster"
}

variable "PROXMOX_VE_ENDPOINT_POLARIS" {
  type        = string
  description = "API endpoint for the Polaris Proxmox cluster"
}

# NEW: per-alias passwords (mark sensitive)
variable "PROXMOX_VE_PASSWORD_SIRIUS" {
  type        = string
  description = "Password for root@pam on Sirius"
  sensitive   = true
}

variable "PROXMOX_VE_PASSWORD_POLARIS" {
  type        = string
  description = "Password for root@pam on Polaris"
  sensitive   = true
}
