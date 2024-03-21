# creates an ATP database
## ATP Instance
resource "oci_database_autonomous_database" "autonomous_database" {
  count = local.is_private ? 0 : 1
  admin_password           = random_string.autonomous_database_admin_password.result
  compartment_id           = var.adb_compartment_ocid
  cpu_core_count           = local.adb_cpu_core_count
  data_storage_size_in_tbs = local.adb_data_storage_size_in_tbs
  db_name                  = "${var.adb_name}${random_string.deploy_id.result}"
  db_version               = local.adb_version
  db_workload              = local.adb_workload
  display_name             = "${var.adb_name}${random_string.deploy_id.result}"
  license_model            = local.adb_license_model
  is_free_tier             = local.is_free_adb
  is_auto_scaling_enabled  = local.adb_enable_auto_scale

  freeform_tags = var.defined_tag.freeformTags
}

resource "oci_database_autonomous_database_wallet" "autonomous_database_wallet" {
  count = local.is_private ? 0 : 1
    #Required
    autonomous_database_id = oci_database_autonomous_database.autonomous_database.0.id
    password = random_string.autonomous_database_admin_password.result

    #Optional
    base64_encode_content = "true"
    generate_type = "SINGLE"
}

resource "local_file" "autonomous_database_wallet_file" {
  count = local.is_private ? 0 : 1
  content_base64 = oci_database_autonomous_database_wallet.autonomous_database_wallet.0.content
  filename       = "wallet.zip"
}

resource "oci_database_autonomous_database" "private_database" {
  count = local.is_private ? 1 : 0
  admin_password           = random_string.autonomous_database_admin_password.result
  compartment_id           = var.adb_compartment_ocid
  cpu_core_count           = local.adb_cpu_core_count
  data_storage_size_in_tbs = local.adb_data_storage_size_in_tbs
  db_name                  = "${var.adb_name}${random_string.deploy_id.result}"
  db_version               = local.adb_version
  db_workload              = local.adb_workload
  display_name             = "${var.adb_name}${random_string.deploy_id.result}"
  license_model            = local.adb_license_model
  is_free_tier             = local.is_free_adb
  is_auto_scaling_enabled  = local.adb_enable_auto_scale
  subnet_id                = local.create_network ? oci_core_subnet.simple_subnet.0.id : var.subnet_id
  nsg_ids                  = local.create_nsg ? [oci_core_network_security_group.simple_nsg.0.id] : [var.use_existing_nsg]

  freeform_tags = var.defined_tag.freeformTags
}