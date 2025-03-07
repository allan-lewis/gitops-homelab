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

resource "proxmox_virtual_environment_vm" "vm_talos" {
  for_each = merge(var.controlplane_list, var.worker_list)

  name      = each.value.vm_name
  node_name = each.value.proxmox_node
  description = each.value.description

  tags        = each.value.tags
  on_boot     = true

  cpu {
    cores = each.value.cpu_cores
    type = "x86-64-v2-AES"
  }

  memory {
    dedicated = each.value.memory_dedicated
  }

  agent {
    enabled = false
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = each.value.datastore_id
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image.id
    file_format  = "raw"
    interface    = "virtio0"
    size         = each.value.disk_size
  }

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
  }

  initialization {
    datastore_id = each.value.datastore_id
    ip_config {
      ipv4 {
        address = each.value.ipv4_address
        gateway = each.value.gateway
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

  # resource "talos_machine_secrets" "machine_secrets" {}

  # data "talos_client_configuration" "talosconfig" {
  #   cluster_name         = "staging"
  #   client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  #   endpoints            = ["192.168.86.96"]
  # }

# data "talos_machine_configuration" "machineconfig_cp" {
#   cluster_name     = "staging"
#   cluster_endpoint = "https://192.168.86.96:6443"
#   machine_type     = "controlplane"
#   kubernetes_version = "1.31.4"
#   machine_secrets  = talos_machine_secrets.machine_secrets.machine_secrets
# }

# resource "talos_machine_configuration_apply" "cp_config_apply" {
#   depends_on                  = [ proxmox_virtual_environment_vm.vm_talos["talos-control-plane-0"] ]
#   client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
#   machine_configuration_input = data.talos_machine_configuration.machineconfig_cp.machine_configuration
#   count                       = 1
#   node                        = "192.168.86.96"
# }

# resource "talos_machine_bootstrap" "bootstrap" {
#   depends_on           = [ talos_machine_configuration_apply.cp_config_apply ]
#   client_configuration = talos_machine_secrets.machine_secrets.client_configuration
#   node                 = "192.168.86.96"
# }

# data "talos_cluster_health" "health" {
#   depends_on           = [ talos_machine_configuration_apply.cp_config_apply ]
#   # depends_on           = [ talos_machine_configuration_apply.cp_config_apply, talos_machine_configuration_apply.worker_config_apply ]
#   client_configuration = data.talos_client_configuration.talosconfig.client_configuration
#   control_plane_nodes  = [ "192.168.86.96" ]
#   # worker_nodes         = [ var.talos_worker_01_ip_addr ]
#   endpoints            = data.talos_client_configuration.talosconfig.endpoints
# }

# resource "talos_cluster_kubeconfig" "kubeconfig" {
#   depends_on           = [ talos_machine_bootstrap.bootstrap, data.talos_cluster_health.health ]
#   client_configuration = talos_machine_secrets.machine_secrets.client_configuration
#   node                 = "192.168.86.96"
# }

# output "talosconfig" {
#   value = data.talos_client_configuration.talosconfig.talos_config
#   sensitive = true
# }

# output "kubeconfig" {
#   value = resource.talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw
#   sensitive = true
# }

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
