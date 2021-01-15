//VCN confiuration

resource "oci_core_vcn" "project1vcn" {
    #Required
    compartment_id = var.compartment_ocid
    #Optional
    cidr_block = "10.0.0.0/16"
    display_name = "project1vcn"
    dns_label = "project1vcn"
}

//Public Subnet
resource "oci_core_subnet" "public_subnet_project1" {
  cidr_block          = "10.0.0.0/24"
  display_name        = "public_subnet_project1"
  dns_label           = "project1vcnpub"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.project1vcn.id
  security_list_ids   = [oci_core_security_list.public_securitylist_project1.id]
 }


//Private Subnet
resource "oci_core_subnet" "private_subnet_project1" {
  cidr_block          = "10.0.1.0/24"
  display_name        = "private_subnet_project1"
  dns_label           = "project1vcnprv"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.project1vcn.id
  security_list_ids   = [oci_core_security_list.private_securitylist_project1.id]
 }

 //Internet Gateway

 resource "oci_core_internet_gateway" "internetgateway_project1" {
  compartment_id = var.compartment_ocid
  display_name   = "internetgateway_project1"
  vcn_id         = oci_core_vcn.project1vcn.id
}

//Route Tables
resource "oci_core_route_table" "routetable_project1" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.project1vcn.id
  display_name   = "routetable_project1"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.internetgateway_project1.id
  }
}

//Security lists Public


  resource "oci_core_security_list" "public_securitylist_project1" {
  display_name   = "public_securitylist_project1"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.project1vcn.id


  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
    
  }

  ingress_security_rules {
    source   = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options {
        min = 22
        max = 22
    }
    }
  ingress_security_rules {
    source   = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options {
        min = 80
        max = 80
    }
    }
    
    ingress_security_rules {
    source   = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options {
        min = 443
        max = 443
    }
    }
    
    ingress_security_rules {
    source   = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options {
        min = 7000
        max = 7000
    }
    }
}


  //Security lists Private

  resource "oci_core_security_list" "private_securitylist_project1" {
  display_name   = "private_securitylist_project1"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.project1vcn.id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    source   = "10.0.0.0/24"
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options {
        min = 8009
        max = 8009
    }
    }
  ingress_security_rules {
    source   = "10.0.0.0/24"
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options {
        min = 8080
        max = 8080
    }
    }
  ingress_security_rules {
    source   = "10.0.0.0/24"
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options {
        min = 22
        max = 22
    }
    }
}
    
//Service Gateway

resource "oci_core_service_gateway" "test_services" {
    #Required
    compartment_id = var.compartment_ocid
    display_name = "project1_service_gateway"
    services {
        #Required
        service_id = data.oci_core_services.test_services.services.0.id
    }
    vcn_id = oci_core_vcn.project1vcn.id

   
}
