/*
locals {
  backendipaddress = oci_core_instance.webservers[*].private_ip
}
*/

//Load Balancer

resource "oci_load_balancer_load_balancer" "project1lb" {
    #Required
    compartment_id = var.compartment_id
    display_name = "project1lb"
    shape = "10Mbps"
    subnet_ids = [oci_core_subnet.public_subnet_project1.id]
 /*
    shape_details {
    maximum_bandwidth_in_mbps = 20
    minimum_bandwidth_in_mbps = 10
    }

 */  
}

//LB Backend

resource "oci_load_balancer_backend" "project1lbbackend1" {
    count = var.webhostcount
    backendset_name = oci_load_balancer_backend_set.project1lbbackendset.name
    ip_address = element(oci_core_instance.webservers[*].private_ip, count.index)
    load_balancer_id = oci_load_balancer_load_balancer.project1lb.id
    port = 80
}


// LB Backend set
resource "oci_load_balancer_backend_set" "project1lbbackendset" {
    #Required
    health_checker {
        #Required
        protocol = "HTTP"

        #Optional
        interval_ms = 10000
        port = 80
        response_body_regex = ".*"
        retries = 3
        return_code = 200
        timeout_in_millis = 3000
        url_path = "/"
    }
    load_balancer_id = oci_load_balancer_load_balancer.project1lb.id
    name = "project1lbbackendset"
    policy = "ROUND_ROBIN"

}



resource "oci_load_balancer_listener" "project1listner" {
    #Required
    default_backend_set_name = oci_load_balancer_backend_set.project1lbbackendset.name
    load_balancer_id = oci_load_balancer_load_balancer.project1lb.id
    name = "project1listner"
    port = 80
    protocol = "HTTP"

}

