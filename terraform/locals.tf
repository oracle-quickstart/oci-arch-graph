locals {

  # Database logic
  is_free_adb = var.adb_type == var.adb_type_enum["ALWAYS_FREE"] ? true : false

  adb_workload = var.adb_workload == var.adb_workload_enum["DW"] ? "DW" : "OLTP"
  adb_license = [for k,v in var.adb_license_model_enum : k if v == var.adb_license_model][0]

  adb_cpu_core_count           = local.is_free_adb ? 1 : var.adb_cpu_core_count
  adb_data_storage_size_in_tbs = local.is_free_adb ? 1 : var.adb_data_storage_size_in_tbs
  adb_enable_auto_scale        = local.is_free_adb ? false : var.adb_enable_auto_scale
  adb_license_model            = local.is_free_adb ? "LICENSE_INCLUDED" : local.adb_license

  adb_version = local.adb_workload == "DW" ? var.adb_version_adw : var.adb_version_atp

  is_private = (local.is_free_adb==false) && (var.access_type == var.access_type_enum["PRIVATE"]) ? true : false

}
