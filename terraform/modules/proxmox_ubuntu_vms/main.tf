terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.76.1"
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm_ubuntu" {
  for_each = var.vm_list

  name      = each.key
  node_name = each.value.proxmox_node
  description = each.value.description

  cpu {
    cores = each.value.cpu_cores
    type = "x86-64-v2-AES"
  }

  memory {
    dedicated = each.value.memory_dedicated
  }

  initialization {
    ip_config {
      ipv4 {
        address = each.value.ipv4_address
        gateway = each.value.gateway
      }
    }

    user_account {
      username = "lab"
      keys = var.public_keys
    }
  }

  disk {
    datastore_id = each.value.datastore_id
    file_id      = "local:iso/ubuntu-24.04-server-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = each.value.disk_size
  }

  network_device {
    bridge = "vmbr0"
  }

  tags = each.value.tags
  on_boot     = true
}

# Rely on environment variables to populate the Proxmox provider!
# https://registry.terraform.io/providers/bpg/proxmox/latest/docs#environment-variables-summary
# provider "proxmox" {
  # Use PROXMOX_VM_PUBLIC_KEY environment variable
  # endpoint = ""

  # Use PROXMOX_VE_USERNAME environment variable
  # username = "root@pam"

  # Use PROXMOX_VE_PASSWORD environment variable
  # password = ""

  # Use PROXMOX_VE_API_TOKEN environment variable
  # api_token = ""
# }
