variable "vm_list_ubuntu" {
  description = "A list of Ubuntu VMs to create"
  default = {
    epsilon = {
      description       = "Ubuntu host (managed by Terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 2
      memory_dedicated  = 4096
      datastore_id      = "local-lvm"
      disk_size         = 64
      ipv4_address      = "192.168.86.94/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "staging", "ubuntu"]
    }
  }
}

variable "vm_list_haos" {
  description = "A list of Ubuntu VMs to create"
  default = {
    zeta = {
      description       = "Home Assistant VM (managed by Terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 4
      memory_dedicated  = 4096
      datastore_id      = "local-lvm"
      disk_size         = 64
      tags              = ["terraform", "staging", "haos"]
    }
  }
}

# Set this from an environment variable called TF_VAR_PROXMOX_VM_PUBLIC_KEY
variable "PROXMOX_VM_PUBLIC_KEY" {}
