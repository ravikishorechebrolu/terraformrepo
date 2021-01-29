data "oci_identity_availability_domains" "adname" {
    compartment_id = var.compartment_id
  }


data "oci_core_images" "reqimg" {
        compartment_id = var.compartment_ocid

        operating_system = "Oracle Linux"
        operating_system_version = "7.8"
        shape = var.instance_shape
}

resource "oci_core_instance" "webservers" {
    count = var.webhostcount
    #for_each = toset( ["1"] )
    availability_domain = element(data.oci_identity_availability_domains.adname.availability_domains[*].name,count.index)
    compartment_id = var.compartment_id
    shape = var.instance_shape
    display_name = "webhost${element(var.instancename, count.index)}"
    source_details {
      source_type= "image"
      source_id= data.oci_core_images.reqimg.images.0.id
    }
    create_vnic_details {
      hostname_label = "webhost${element(var.instancename, count.index)}"
      assign_public_ip = "true"
      subnet_id = oci_core_subnet.public_subnet_project1.id
    }

    metadata = {
      user_data = data.cloudinit_config.webserverinit.rendered
      ssh_authorized_keys = var.ssh_public_key 
    }

    timeouts {
      create = "10m"
    }
}


resource "oci_core_instance" "appservers" {
    #for_each = toset( ["1"] )
    count = 1
    availability_domain = element(data.oci_identity_availability_domains.adname.availability_domains[*].name,count.index)
    compartment_id = var.compartment_id
    shape = var.instance_shape
    display_name = "apphost${element(var.instancename, count.index)}"
    source_details {
      source_type= "image"
      source_id= data.oci_core_images.reqimg.images.0.id
    }
    create_vnic_details {
      hostname_label = "apphost${element(var.instancename, count.index)}"
      assign_public_ip = "false"
      subnet_id = oci_core_subnet.private_subnet_project1.id
    }

    metadata = {
      user_data = data.cloudinit_config.appserverinit.rendered
      ssh_authorized_keys = var.ssh_public_key 
    }

    timeouts {
      create = "10m"
    }
}
