variable "vm_list_ubuntu" {
  description = "A list of Ubuntu VMs to create"
  default = {
    castor = {
      description       = "DevOps host for the staging environment (managed by Terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 2
      memory_dedicated  = 2048
      datastore_id      = "local-lvm"
      disk_size         = 64
      ipv4_address      = "192.168.86.125/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "devops", "ubuntu"]
    }
    pollux = {
      description       = "DevOps host for the production environment (managed by Terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 2
      memory_dedicated  = 2048
      datastore_id      = "local-lvm"
      disk_size         = 256
      ipv4_address      = "192.168.86.135/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "devops", "ubuntu"]
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
