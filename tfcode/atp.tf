/* resource "oci_database_autonomous_database" "project1atp" {
  compartment_id = var.compartment_ocid
  admin_password = var.autonomous_database_admin_password
  cpu_core_count = "1"
  data_storage_size_in_tbs = var.autonomous_database_data_storage_size_in_tbs
  db_name = var.autonomous_database_db_name
  db_version = "19c"
  db_workload = "OLTP"
  display_name = var.autonomous_database_display_name
  freeform_tags = { "tenancy" = "srepreprod1" }
  license_model = "LICENSE_INCLUDED"
  subnet_id = oci_core_subnet.private_subnet_project1.id
  nsg_ids = [oci_core_network_security_group.nsgforatp.id]
  private_endpoint_label = "project1atp"
} */