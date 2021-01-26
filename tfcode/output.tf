output "Servicename" {
    value = data.oci_core_services.test_services.services.0
  
}

locals {
  reqop = tomap({"oci_core_instance.webservers[*].display_name"="oci_core_instance.webservers[*].public_ip"})
}

output "ipmap" {
    value = local.reqop  
}

# if the above one does not work.
output "publicips" {
    value = oci_core_instance.webservers[*].public_ip
  
}


output "privateips" {
  value = oci_core_instance.webservers[*].private_ip
}