# creates an ATP database
## ATP Instance
resource "oci_database_autonomous_database" "autonomous_database" {
  admin_password           = random_string.autonomous_database_admin_password.result
  compartment_id           = var.adb_compartment_ocid
  cpu_core_count           = local.adb_cpu_core_count
  data_storage_size_in_tbs = local.adb_data_storage_size_in_tbs
  db_name                  = "${var.adb_name}${random_string.deploy_id.result}"
  db_version               = var.adb_version
  db_workload              = local.adb_workload
  display_name             = "${var.adb_name}${random_string.deploy_id.result}"
  license_model            = local.adb_license_model
  is_free_tier             = local.is_free_adb
  is_auto_scaling_enabled  = local.adb_enable_auto_scale

  freeform_tags = var.defined_tag.freeformTags
  defined_tags  = var.defined_tag.definedTags
}

resource "oci_database_autonomous_database_wallet" "autonomous_database_wallet" {
    #Required
    autonomous_database_id = oci_database_autonomous_database.autonomous_database.id
    password = random_string.autonomous_database_admin_password.result

    #Optional
    base64_encode_content = "true"
    generate_type = "SINGLE"
}

resource "local_file" "autonomous_database_wallet_file" {
  content_base64 = oci_database_autonomous_database_wallet.autonomous_database_wallet.content
  filename       = "wallet.zip"
}