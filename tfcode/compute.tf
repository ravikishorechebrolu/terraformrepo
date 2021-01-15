data "oci_identity_availability_domains" "adname" {
    compartment_id = var.compartment_id
  }


resource "oci_core_instance" "vminstance" {
    for_each = toset( ["1"] )
    availability_domain = data.oci_identity_availability_domains.adname.availability_domains[2].name
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
      subnet_id = oci_core_subnet.public_subnet_project1.id
    }

    metadata = {
      userdata = base64encode(file("./cloudinitdata/webservers"))
      ssh_authorized_keys = var.ssh_public_key 
    }
}


resource "oci_core_instance" "appservers" {
    for_each = toset( ["1"] )
    availability_domain = data.oci_identity_availability_domains.adname.availability_domains[1].name
    compartment_id = var.compartment_id
    shape = var.instance_shape
    display_name = "apphost${each.key}"
    source_details {
      source_type= "image"
      source_id= var.image_id
    }
    create_vnic_details {
      hostname_label = "apphost${each.key}"
      assign_public_ip = "true"
      subnet_id = oci_core_subnet.private_subnet_project1.id
    }

    metadata = {
      userdata = base64encode(file("./cloudinitdata/appservers"))
      ssh_authorized_keys = var.ssh_public_key 
    }
}
