terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.84.0"
    }
  }
}

# Aliased providers, each with its own endpoint + password
provider "proxmox" {
  alias    = "sirius"
  endpoint = var.PROXMOX_VE_ENDPOINT_SIRIUS
  username = "root@pam"
  password = var.PROXMOX_VE_PASSWORD_SIRIUS
  insecure = false
}

provider "proxmox" {
  alias    = "polaris"
  endpoint = var.PROXMOX_VE_ENDPOINT_POLARIS
  username = "root@pam"
  password = var.PROXMOX_VE_PASSWORD_POLARIS
  insecure = false
}

# default config to satisfy anything that expects an unaliased provider
provider "proxmox" {
  endpoint = var.PROXMOX_VE_ENDPOINT_SIRIUS
  username = "root@pam"
  password = var.PROXMOX_VE_PASSWORD_SIRIUS
  insecure = false   # or true if you must skip TLS validation
}

module "devops_proxmox_ubuntu_vms" {
  source      = "../../modules/proxmox_ubuntu_vms"
  vm_list     = var.vm_list_ubuntu
  public_keys = [var.PROXMOX_VM_PUBLIC_KEY]

  # Pass both aliases into the child (names must match child aliases)
  providers = {
    proxmox.sirius  = proxmox.sirius
    proxmox.polaris = proxmox.polaris
  }
}
