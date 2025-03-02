terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.73.0"
    }
  }
}

provider "proxmox" {
  # https://registry.terraform.io/providers/bpg/proxmox/latest/docs#environment-variables-summary

  # Use PROXMOX_VM_PUBLIC_KEY environment variable
  # endpoint = ""

  # Use PROXMOX_VE_USERNAME environment variable
  # username = "root@pam"

  # Use PROXMOX_VE_PASSWORD environment variable
  # password = ""

  # Use PROXMOX_VE_API_TOKEN environment variable
  # api_token = ""
}

# Set this from an environment variable called TF_VAR_PROXMOX_VM_PUBLIC_KEY
variable "PROXMOX_VM_PUBLIC_KEY" {}

# resource "proxmox_virtual_environment_vm" "ubuntu_vm_openvpn" {
#   name      = "alcor"
#   node_name = "polaris"

#   cpu {
#     cores = 2
#   }

#   memory {
#     dedicated = 2048
#   }

#   initialization {
#     ip_config {
#       ipv4 {
#         address = "192.168.86.123/24"
#         gateway = "192.168.86.1"
#       }
#     }

#     user_account {
#       username = "lab"
#       keys = [var.PROXMOX_VM_PUBLIC_KEY]
#     }
#   }

#   disk {
#     datastore_id = "local-ssd"
#     file_id      = "local:iso/ubuntu-24.04-server-cloudimg-amd64.img"
#     interface    = "virtio0"
#     iothread     = true
#     discard      = "on"
#     size         = 64
#   }

#   network_device {
#     bridge = "vmbr0"
#   }

#   tags = ["terraform", "production", "ubuntu", "openvpn"]
# }

resource "proxmox_virtual_environment_vm" "ubuntu_vm_ops" {
  name      = "procyon"
  node_name = "polaris"

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.86.125/24"
        gateway = "192.168.86.1"
      }
    }

    user_account {
      username = "lab"
      keys = [var.PROXMOX_VM_PUBLIC_KEY]
    }
  }

  disk {
    datastore_id = "local-ssd"
    file_id      = "local:iso/ubuntu-24.04-server-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 64
  }

  network_device {
    bridge = "vmbr0"
  }

  tags = ["terraform", "production", "ubuntu", "ops"]
}
