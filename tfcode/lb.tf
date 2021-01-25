//Load Balancer

resource "oci_load_balancer_load_balancer" "project1lb" {
    #Required
    compartment_id = var.compartment_id
    display_name = project1lb
    shape = "Flexible"
    subnet_ids = oci_core_subnet.public_subnet_project1.id

    shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
    }
}

//LB Backend

resource "oci_load_balancer_backend" "project1lbbackend" {
    #Required
    backendset_name = oci_load_balancer_backend_set.project1lbbackendset.name
    ip_address = var.backend_ip_address
    load_balancer_id = oci_load_balancer_load_balancer.project1lb.id
    port = 80
}


// LB Backend set
resource "oci_load_balancer_backend_set" "project1lbbackendset" {
    #Required
    health_checker {
        #Required
        protocol = var.backend_set_health_checker_protocol

        #Optional
        interval_ms = var.backend_set_health_checker_interval_ms
        port = var.backend_set_health_checker_port
        response_body_regex = var.backend_set_health_checker_response_body_regex
        retries = var.backend_set_health_checker_retries
        return_code = var.backend_set_health_checker_return_code
        timeout_in_millis = var.backend_set_health_checker_timeout_in_millis
        url_path = var.backend_set_health_checker_url_path
    }
    load_balancer_id = oci_load_balancer_load_balancer.project1lb.id
    name = "project1lbbackendset"
    policy = var.backend_set_policy
}
