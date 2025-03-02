terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.73.0"
    }
  }
}

# provider "proxmox" {
  # https://registry.terraform.io/providers/bpg/proxmox/latest/docs#environment-variables-summary

  # Use PROXMOX_VM_PUBLIC_KEY environment variable
  # endpoint = ""

  # Use PROXMOX_VE_USERNAME environment variable
  # username = "root@pam"

  # Use PROXMOX_VE_PASSWORD environment variable
  # password = ""

  # Use PROXMOX_VE_API_TOKEN environment variable
  # api_token = ""
# }

resource "proxmox_virtual_environment_vm" "vm_ubuntu" {
  name      = var.vm_name
  node_name = var.proxmox_node

  cpu {
    cores = var.cpu_cores
  }

  memory {
    dedicated = var.memory_dedicated
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = "192.168.86.1"
      }
    }

    user_account {
      username = "lab"
      keys = var.user_account_keys
    }
  }

  disk {
    datastore_id = var.datastore_id
    file_id      = "local:iso/ubuntu-24.04-server-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.disk_size
  }

  network_device {
    bridge = "vmbr0"
  }

  tags = var.tags
}