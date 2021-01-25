data "oci_identity_availability_domains" "adname" {
    compartment_id = var.compartment_id
  }




resource "oci_core_instance" "webservers" {
    count = 1
    #for_each = toset( ["1"] )
    availability_domain = element(data.oci_identity_availability_domains.adname.availability_domains[*].name,count.index)
    compartment_id = var.compartment_id
    shape = var.instance_shape
    display_name = "webhost${element(var.instancename, count.index)}"
    source_details {
      source_type= "image"
      source_id= var.image_id
    }
    create_vnic_details {
      hostname_label = "webhost${element(var.instancename, count.index)}"
      assign_public_ip = "true"
      subnet_id = oci_core_subnet.public_subnet_project1.id
    }

    metadata = {
      #userdata = base64encode(file("./cloudinitdata/webservers.sh"))
      #userdata = base64encode(var.webuserdata)
      #userdata = base64encode(file("./cloudinitdata/webservers"))
      #user_data = base64encode(file(var.webcustom_bootstrap_file_name))
      user_data = data.cloudinit_config.webserverinit.rendered
      ssh_authorized_keys = var.ssh_public_key 
    }

    timeouts {
      create = "10m"
    }
}


/* resource "oci_core_instance" "appservers" {
    #for_each = toset( ["1"] )
    count = 1
    availability_domain = element(data.oci_identity_availability_domains.adname.availability_domains[*].name,count.index)
    compartment_id = var.compartment_id
    shape = var.instance_shape
    display_name = "apphost${element(var.instancename, count.index)}"
    source_details {
      source_type= "image"
      source_id= var.image_id
    }
    create_vnic_details {
      hostname_label = "apphost${element(var.instancename, count.index)}"
      assign_public_ip = "true"
      subnet_id = oci_core_subnet.private_subnet_project1.id
    }

    metadata = {
      userdata = base64encode(file("./cloudinitdata/appservers"))
      ssh_authorized_keys = var.ssh_public_key 
    }

    timeouts {
      create = "10m"
    }
}
 */