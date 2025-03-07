variable "vm_list_ubuntu" {
  description = "A list of Ubuntu VMs to create"
  default = {
    devops-0 = {
      vm_name           = "alpha"
      description       = "OpenVPN Gateway managed by Terraform"
      proxmox_node      = "polaris"
      cpu_cores         = 2
      memory_dedicated  = 2048
      datastore_id      = "local-lvm"
      disk_size         = 64
      ipv4_address      = "192.168.86.90/24"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "staging", "ubuntu", "devops"]
    }
  }
}

variable "controlplane_list" {
  description = "A list of Talos Control Plane VMs to create"
  default = {
    talos-controlplane-0 = {
      vm_name           = "beta"
      description       = "Talos Linux control plane node managed by Terraform"
      proxmox_node      = "polaris"
      cpu_cores         = 2
      memory_dedicated  = 2048
      datastore_id      = "local-lvm"
      disk_size         = 32
      ipv4_address      = "192.168.86.91"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "staging", "talos", "controlplane"]
    }
  }
}

variable "worker_list" {
  description = "A list of Talos Control Plane VMs to create"
  default = {
    talos-worker-0 = {
      vm_name           = "gamma"
      description       = "Talos Linux worker node managed by Terraform"
      proxmox_node      = "polaris"
      cpu_cores         = 4
      memory_dedicated  = 8192
      datastore_id      = "local-lvm"
      disk_size         = 256
      ipv4_address      = "192.168.86.92"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "staging", "talos", "worker"]
    }
    talos-worker-1 = {
      vm_name           = "delta"
      description       = "Talos Linux worker node managed by Terraform"
      proxmox_node      = "polaris"
      cpu_cores         = 4
      memory_dedicated  = 8192
      datastore_id      = "local-lvm"
      disk_size         = 256
      ipv4_address      = "192.168.86.93"
      gateway           = "192.168.86.1"
      tags              = ["terraform", "staging", "talos", "worker"]
    }
    talos-worker-2 = {
      vm_name           = "epsilon"
      description       = "Talos Linux worker node managed by Terraform (w/ OpenVPN gateway)"
      proxmox_node      = "polaris"
      cpu_cores         = 2
      memory_dedicated  = 4096
      datastore_id      = "local-lvm"
      disk_size         = 64
      ipv4_address      = "192.168.86.94"
      gateway           = "192.168.86.123"
      tags              = ["terraform", "staging", "talos", "worker"]
    }
  }
}

# Set this from an environment variable called TF_VAR_PROXMOX_VM_PUBLIC_KEY
variable "PROXMOX_VM_PUBLIC_KEY" {}
