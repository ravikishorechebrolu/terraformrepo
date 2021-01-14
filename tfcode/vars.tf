variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {
    description = "Private key path of the pem file"
}
variable "region" {
    description = "Region we want to deploy the Infra"
}
variable "compartment_id" {
    description = "OCID of OCSC sandbox compartment"
  }

variable "instance_shape" {
    description = "requried shape for compute"
    default = "VM.Standard2.1"  
}

variable "image_id" {
    description = "Image id for Oracle Linux 7.8"
    default = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaafjcegvwbd3qgin4unmtr5jm5gjhtcfxgnhjwodzewlja5zqm6eaq"
  
}

variable "webuserdata" {
    default = "./cloudinitdata/webservers"
}

/* variable "ssh_public_key" {
    default = "./cloudintidata/webserversshpublickey"
  
} */