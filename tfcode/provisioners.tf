resource "oci_core_instance" "test_instance" {
    #Required
    availability_domain = "DEvy:AP-HYDERABAD-1-AD-1"
    compartment_id = var.appdevcomp
    shape = "VM.Standard.E2.1.Micro"
    source_details {
        #Required
        source_id = "<>"
        source_type = "image"
    }
    create_vnic_details {

        #Optional
        assign_public_ip = true
        subnet_id = "<>"
    }

    metadata = {
        ssh_authorized_keys = file("./id_rsa.pub")
     }

    provisioner "local-exec" {
      # To test the local-exec workflow-- below one can be achieved by output block
      command = "echo ${self.public_ip} >> ip.txt"
      
    }


/*     provisioner "remote-exec" {
        inline = [
          "sudo yum install -y nginx1.12",
          "sudo systemctl start nginx"
        ]
        connection {
          type = "ssh"
          user = "opc"
          host = "${self.public_ip}"
          private_key = file("./id_rsa")
        }
        
    } */

}
