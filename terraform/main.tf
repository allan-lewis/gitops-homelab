terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.73.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://192.168.86.101:8006/"

  # because self-signed TLS certificate is in use
  insecure = true
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = "test-ubuntu"
  node_name = "polaris"

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.86.233/24"
        gateway = "192.168.86.1"
      }
    }

    user_account {
      username = "ubuntu"
      password = "password"
    }
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = "local:iso/ubuntu-24.04-server-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }
}
