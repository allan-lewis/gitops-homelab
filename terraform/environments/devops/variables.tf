variable "vm_list_ubuntu" {
  description = "A list of Ubuntu VMs to create"
  default = {
    callahan = {
      description       = "devops host for the staging environment (managed by terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 2
      memory_dedicated  = 4096
      datastore_id      = "local-lvm"
      disk_size         = 64
      ipv4_address      = "192.168.86.215/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "devops", "ubuntu"]
    }
    barlow = {
      description       = "devops host for the production environment (managed by terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 2
      memory_dedicated  = 4096
      datastore_id      = "local-lvm"
      disk_size         = 128
      ipv4_address      = "192.168.86.225/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "devops", "ubuntu"]
    }
    todash = {
      description       = "host for tinkering and testing (managed by terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 4
      memory_dedicated  = 4096
      datastore_id      = "local-lvm"
      disk_size         = 128
      ipv4_address      = "192.168.86.69/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "tinker", "ubuntu"]
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
