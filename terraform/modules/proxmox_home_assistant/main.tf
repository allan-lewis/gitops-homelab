terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.78.0"
    }
  }
}

# Register the HAOS QCOW2 file as a disk image in Proxmox storage
resource "proxmox_virtual_environment_file" "haos_disk" {
  content_type = "disk-image"
  datastore_id = "local-lvm"
  node_name    = "polaris"

  source_file {
    path = "/var/lib/vz/template/iso/haos_ova-15.2.qcow2"
  }
}

resource "proxmox_virtual_environment_vm" "vm_haos" {
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

  disk {
    datastore_id = "local-lvm"
    file_id      = "local-lvm:vm-199-disk-0"
    interface    = "scsi0"
    iothread     = true
    discard      = true
  }

  network_device {
    bridge = "vmbr0"
  }

  tags = each.value.tags
  on_boot     = true
}
