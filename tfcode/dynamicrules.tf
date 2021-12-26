variable "portslist" {
    type = list(number)
    default = [22, 80, 443, 7000, 8080, 9009, 9000]
  
}

resource "oci_core_security_list" "test_security_list" {
    #Required
    compartment_id = "<>"
    vcn_id = "<>"
    display_name = "dynamic_rules"
    dynamic "ingress_security_rules" {
         for_each = var.portslist
         content{
            source      = "10.0.0.0/24"
            source_type = "CIDR_BLOCK"
            protocol    = "6"
            tcp_options {
                min = ingress_security_rules.value
                max = ingress_security_rules.value
            }
        }
    }
}





#### with iterator.
resource "oci_core_security_list" "test_security_list" {
    #Required
    compartment_id = "<>"
    vcn_id = "<>"
    display_name = "dynamic_rules"
    dynamic "ingress_security_rules" {
         for_each = var.portslist
         iterator = rule
         content{
            source      = "10.0.0.0/24"
            source_type = "CIDR_BLOCK"
            protocol    = "6"
            tcp_options {
                min = rule.value
                max = rule.value
            }
        }
    }
}
