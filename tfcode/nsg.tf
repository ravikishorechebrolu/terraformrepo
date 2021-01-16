resource "oci_core_network_security_group" "nsgforatp" {
    compartment_id = var.compartment_ocid
    display_name = "nsgforatp"
    vcn_id = oci_core_vcn.project1vcn.id
}

resource "oci_core_network_security_group_security_rule" "egressforatp" {
    network_security_group_id = oci_core_network_security_group.nsgforatp.id
    direction = "EGRESS"
    protocol = "6"
    destination = var.mainvcnid
    destination_type = "CIDR_BLOCK"
}

resource "oci_core_network_security_group_security_rule" "ingressforatp" {
    network_security_group_id = oci_core_network_security_group.nsgforatp.id
    direction = "INGRESS"
    protocol = "6"
    source = var.mainvcnid
    source_type = "CIDR_BLOCK"
    tcp_options {
        destination_port_range {
            max = 1522
            min = 1522
        }
    }
}