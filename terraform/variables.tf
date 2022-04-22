/* 
* Copyright (c) 2020, 2022, Oracle and/or its affiliates. 
 * Variables file with defaults. These can be overridden from environment variables TF_VAR_<variable name>
 *
 * Following are generally configured in environment variables - please use env_vars_template to create env_vars and source it as:
 * source ./env_vars
 * before running terraform init
 */

/*
********************
* ADB Config
********************
*/
variable "adb_type_enum" {
  type = map
  default = {
    ALWAYS_FREE = "Always Free Oracle Autonomous Data Warehouse (1 OCPU 20 GB Storage)"
    PAID        = "Paid Oracle Autonomous Database"
  }
}

variable "adb_workload_enum" {
  type = map
  default = {
    DW   = "Autonomous Data Warehouse"
    OLTP = "Autonomous Transaction Processing"
  }
}

variable "adb_license_model_enum" {
    type = map
    default = {
        LICENSE_INCLUDED       = "License Included"
        BRING_YOUR_OWN_LICENSE = "Bring Your Own License (BYOL)"
    }
}

variable "adb_type" {
  default = "Paid Oracle Autonomous Database"
}

variable "adb_compartment_ocid" {
}

variable "adb_name" {
  default = "gsrademo"
}

variable "adb_version" {
  default = "19c"
}
variable "adb_license_model" {
  default = "License Included" # LICENSE_INCLUDED or BRING_YOUR_OWN_LICENSE
}
variable "adb_cpu_core_count" {
  default = 1
}
variable "adb_data_storage_size_in_tbs" {
  default = 1
}
variable "adb_enable_auto_scale" {
  default = true
}
variable "adb_workload" {
  default = "Autonomous Transaction Processing"
}

/*
********************
* Tag Config
********************
*/

variable "show_tag_options" {
  default = true
}

variable  "defined_tag" {
  type = map(map(string))
  default = {
    "freeformTags" = {
      "oracle-quickstart" = "oracle-graphstudio"
    }
  }
}

/*
********************
* Hidden Variables
********************
*/
variable "tenancy_ocid" {}

variable "region" {}

variable "compartment_ocid" {}
