provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = var.user_ocid
  fingerprint = var.fingerprint
  private_key_path = var.private_key_path
  region = var.region
}


terraform {
  required_providers {
    cloudinit = {
      source = "hashicorp/cloudinit"
      version = "2.1.0"
    }
  }
}

provider "cloudinit" {
  # Configuration options
}