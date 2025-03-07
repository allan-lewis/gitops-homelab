variable "vm_list_ubuntu" {
  description = "A list of Ubuntu VMs to create"
  default = {
    devops-0 = {
      vm_name           = "procyon"
      description       = "OpenVPN Gateway managed by Terraform"
      proxmox_node      = "polaris"
      cpu_cores         = 2
      memory_dedicated  = 2048
      datastore_id      = "local-ssd"
      disk_size         = 64
      ipv4_address      = "192.168.86.125/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "staging", "ubuntu", "devops"]
    }
  }
}

variable "controlplane_list" {
  description = "A list of Talos Control Plane VMs to create"
  default = {
    talos-controlplane-0 = {
      vm_name           = "fomalhaut"
      description       = "Talos Linux control node managed by Terraform"
      proxmox_node      = "polaris"
      cpu_cores         = 2
      memory_dedicated  = 2048
      datastore_id      = "local-ssd"
      disk_size         = 32
      ipv4_address      = "192.168.86.96/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "staging", "talos", "controlplane"]
    }
  }
}

variable "worker_list" {
  description = "A list of Talos Control Plane VMs to create"
  default = {
    talos-worker-0 = {
      vm_name           = "spica"
      description       = "Talos Linux worker node managed by Terraform"
      proxmox_node      = "polaris"
      cpu_cores         = 4
      memory_dedicated  = 4096
      datastore_id      = "local-ssd"
      disk_size         = 64
      ipv4_address      = "192.168.86.97/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "staging", "talos", "worker"]
    }
  }
}

# Set this from an environment variable called TF_VAR_PROXMOX_VM_PUBLIC_KEY
variable "PROXMOX_VM_PUBLIC_KEY" {}