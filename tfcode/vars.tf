variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {
    description = "Private key path of the pem file"
}
variable "region" {
    description = "Region we want to deploy the Infra"
}
variable "compartment_ocid" {
    description = "OCID of OCSC sandbox compartment"
  }