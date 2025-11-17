variable "vm_list_ubuntu" {
  description = "A list of Ubuntu VMs to create"
  default = {
    cujo = {
      description       = "OpenVPN/Media Acquisition (managed by Terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 4
      memory_dedicated  = 8192
      datastore_id      = "local-lvm"
      disk_size         = 128
      ipv4_address      = "192.168.86.226/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "production", "ubuntu", "openvpn", "media"]
    }
    misery = {
      description       = "Media host (managed by Terraform)"
      proxmox_node      = "sirius"
      cpu_cores         = 4
      memory_dedicated  = 8192
      datastore_id      = "local-lvm"
      disk_size         = 128
      ipv4_address      = "192.168.86.227/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "production", "ubuntu", "media"]
    }
    carrie = {
      description       = "Media host (managed by Terraform)"
      proxmox_node      = "sirius"
      cpu_cores         = 4
      memory_dedicated  = 4096
      datastore_id      = "local-lvm"
      disk_size         = 64
      ipv4_address      = "192.168.86.228/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "production", "ubuntu", "docker", "apps"]
    }
    sheemie = {
      description       = "Local GitHub runner (managed by Terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 4
      memory_dedicated  = 8192
      datastore_id      = "local-lvm"
      disk_size         = 96
      ipv4_address      = "192.168.86.229/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "production", "ubuntu", "github"]
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
