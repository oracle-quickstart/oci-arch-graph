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
    DW   = "Data Warehouse (Serverless Infrastructure)"
    OLTP = "Transaction Processing (Serverless Infrastructure)"
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
variable "adb_version_adw" {
  default = "19c"
}
variable "adb_version_atp" {
  default = "19c"
}
variable "adb_license_model" {
  default = "License Included" # LICENSE_INCLUDED or BRING_YOUR_OWN_LICENSE
}
variable "adb_cpu_core_count" {
  default = 2
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
* Network
********************
*/
variable "access_type" {
  default = "Private endpoint access only"
}

variable "access_type_enum" {
    type = map
    default = {
        PRIVATE = "Private endpoint access only"
        PUBLIC = "Secure access from everywhere"
    }
}

variable "network_compartment_id" { 
  default = ""
}

variable "existing_vcn_id" { 
  default = ""
}

variable "subnet_id" { 
  default = ""
}

variable "nsg_strategy" {
  default = "Create a new NSG"
}

variable "nsg_strategy_enum" {
  type = map 
  default = {
    USE_NEW = "Create a new NSG"
    EXISTING = "Use an existing NSG"
  }
}

variable "nsg_label" {
  default = "allow graphs bastion"
}

variable "use_existing_nsg" {
  default = ""
}

variable "vcn_strategy_enum" {
  type = map
  default = {
    CREATE_VCN = "Create New VCN"
    USE_VCN    = "Use Existing VCN"
  }
}

variable "vcn_strategy" {
  default = "Create New VCN"
}

variable "vcn_name" {
  default = ""
}

variable "vcn_cidr" {
  default = ""
}

variable "subnet_cidr" {
  default = ""
}



/*
********************
* Bastion
********************
*/
variable "bastion_name" {
  default = "graphDBBastion"
}

variable "cidr_allowlist" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "max_ttl" {
  default = 180
}

// Note: This is the opc user's SSH public key text and not the key file path.
variable "ssh_public_key" { 
  default = ""
 }

/*
********************
* Tag Config
********************
*/

variable "show_tag_options" {
  default = false
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
