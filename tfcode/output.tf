output "Servicename" {
    value = data.oci_core_services.test_services.services.0
  
}

output "publicips" {
    value = oci_core_instance.webservers[*].public_ip
  
}