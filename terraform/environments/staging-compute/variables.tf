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
    regulus = {
      description       = "Media host (managed by Terraform)"
      proxmox_node      = "polaris"
      cpu_cores         = 4
      memory_dedicated  = 8192
      datastore_id      = "local-lvm"
      disk_size         = 64
      ipv4_address      = "192.168.86.116/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "production", "ubuntu", "media"]
    }
  }
}

# Set this from an environment variable called TF_VAR_PROXMOX_VM_PUBLIC_KEY
variable "PROXMOX_VM_PUBLIC_KEY" {}
