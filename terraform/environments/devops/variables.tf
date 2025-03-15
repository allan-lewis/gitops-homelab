variable "vm_list_ubuntu" {
  description = "A list of Ubuntu VMs to create"
  default = {
    castor = {
      description       = "DevOps host for the staging environment (managed by Terraform)"
      proxmox_node      = "sirius"
      cpu_cores         = 2
      memory_dedicated  = 2048
      datastore_id      = "ssd0"
      disk_size         = 64
      ipv4_address      = "192.168.86.125/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "devops", "ubuntu"]
    }
    pollux = {
      description       = "DevOps host for the production environment (managed by Terraform)"
      proxmox_node      = "sirius"
      cpu_cores         = 2
      memory_dedicated  = 2048
      datastore_id      = "ssd0"
      disk_size         = 64
      ipv4_address      = "192.168.86.135/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "devops", "ubuntu"]
    }
  }
}

# Set this from an environment variable called TF_VAR_PROXMOX_VM_PUBLIC_KEY
variable "PROXMOX_VM_PUBLIC_KEY" {}
