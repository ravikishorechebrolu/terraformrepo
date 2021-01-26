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

variable "compartment_ocid" {
    description = "Some part of collab code is using compartment_ocid instead of compartment_id "
  }

variable "instance_shape" {
    description = "requried shape for compute"
    default = "VM.Standard2.1"  
}

variable "image_id" {
    description = "Image id for Oracle Linux 7.8"
    default = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaafjcegvwbd3qgin4unmtr5jm5gjhtcfxgnhjwodzewlja5zqm6eaq"
  
}

variable "mainvcnid" {}

variable "instancename" {
  type    = list
  default = [1,2,3,4,5,6]
}

/* variable "webuserdata" {
    default = "./cloudinitdata/webservers"
} */

variable "ssh_public_key" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCirAyE4R/4x8HyOSrZJrz3UJVZNKUBRDloQ29TdDZ2uvvS6F/0qYlTAX8V0TIts/kMzYHolwEd6O7AYhrVWTPYi1qIGYG6q/RR5p1UkVh+jR9V6l6TsJ6VAbgDcXzclqPtJGP9esUqzC8+hmfIwGJ3usCt8cjbYWaYZSINO5tgMBWONonPBTGJStHK08cQmKLVTxStswN/K5fA1tXdk0xdEJ/t7qCSEm+tO4lQa2Whw0vrzpQ9y3AKX0/2W+yUSZMHkCA7V4M6sdiZU6FQVQQruQ4p2frKV+LFN9I6Zn3lDGiWUrnSsN15Ipo+KKEG1IRwy91SzhSsk4GG8u1gY+ip"
  
}


variable "webhostcount" {
default = 2
  
}

# variable "webcustom_bootstrap_file_name" {}

/* variable "webuserdata" {
    default = <<EOF
    #!/bin/bash
    touch /tmp/started
    yum -y install httpd

    #Start the service
    systemctl enable httpd.service
    systemctl start httpd.service


    #Make changes to firewalld
    # firewall-offline-cmd --add-service=http
    # firewall-offline-cmd --add-service=ssh
    systemctl enable firewalld
    systemctl restart firewalld
    firewall-cmd --zone=public --add-service=http
    firewall-cmd --zone=public --add-service=ssh
    firewall-cmd --reload

    #Update index.html
    hostname > /var/www/html/index.html
    touch /tmp/completed
    EOF
}
 */


# ATP related variables

/*
variable "autonomous_database_admin_password" {
    description = "Password for ADMIN user"
}

variable "autonomous_database_db_name" {
    description = "DBNAME"
}
variable "autonomous_database_data_storage_size_in_tbs" {
    description = "In integer values , floating numbers like 1.5 are not accepeted"
}
variable "autonomous_database_display_name" {
    description = "Display Name"
}

*/