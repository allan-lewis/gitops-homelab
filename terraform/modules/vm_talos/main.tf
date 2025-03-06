terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.73.0"
    }
    talos = {
      source = "siderolabs/talos"
      version = "0.7.1"
    }
  }
}

resource "proxmox_virtual_environment_vm" "talos_cp_01" {
  name        = "talos-cp-01"
  description = "Managed by Terraform"
  tags        = ["terraform"]
  node_name   = "polaris"
  on_boot     = true

  cpu {
    cores = 2
    type = "x86-64-v2-AES"
  }

  memory {
    dedicated = 2048
  }

  agent {
    enabled = false
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image.id
    file_format  = "raw"
    interface    = "virtio0"
    size         = 32
  }

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
  }

  initialization {
    datastore_id = "local-lvm"
    ip_config {
      ipv4 {
        address = "192.168.86.96/24"
        gateway = "192.168.86.1"
      }
      ipv6 {
        address = "dhcp"
      }
    }
  }
}

locals {
  talos = {
    version = "v1.9.1"
  }
}

resource "proxmox_virtual_environment_download_file" "talos_nocloud_image" {
  content_type            = "iso"
  datastore_id            = "local"
  node_name               = "polaris"

  file_name               = "talos-${local.talos.version}-nocloud-amd64.img"
  url                     = "https://factory.talos.dev/image/613e1592b2da41ae5e265e8789429f22e121aab91cb4deb6bc3c0b6262961245/${local.talos.version}/nocloud-amd64.raw.gz"
  decompression_algorithm = "gz"
  overwrite               = false
}
