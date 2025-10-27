variable "controlplane_list" {
  description = "A list of Talos Control Plane VMs to create"
  default = {
    beta = {
      description       = "Talos Linux control plane node (managed by Terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 4
      memory_dedicated  = 4096
      datastore_id      = "local-ssd"
      disk_size         = 64
      ipv4_address      = "192.168.86.91"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "staging", "talos", "controlplane"]
    }
  }
}

variable "worker_list" {
  description = "A list of Talos Control Plane VMs to create"
  default = {
    gamma = {
      description       = "Talos Linux worker node (managed by Terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 4
      memory_dedicated  = 8192
      datastore_id      = "local-ssd"
      disk_size         = 256
      ipv4_address      = "192.168.86.92"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "staging", "talos", "worker"]
    }
  }
}

# Set this from an environment variable called TF_VAR_PROXMOX_VM_PUBLIC_KEY
variable "PROXMOX_VM_PUBLIC_KEY" {}

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

