data "oci_identity_availability_domains" "adname" {
    compartment_id = var.compartment_id
  }


resource "oci_core_instance" "vminstance" {
    for_each = toset( ["1", "2"] )
    availability_domain = data.oci_identity_availability_domains.adname.availability_domains[0].name
    compartment_id = var.compartment_id
    shape = var.instance_shape
    display_name = "webhost${each.key}"
    source_details {
      source_type= "image"
      source_id= var.image_id
    }
    create_vnic_details {
      hostname_label = "webhost${each.key}"
      assign_public_ip = "true"
    }

    metadata = {
      userdata = base64encode(file(var.webuserdata))
    #   ssh_authorized_keys = var.ssh_public_key 
    }
}



