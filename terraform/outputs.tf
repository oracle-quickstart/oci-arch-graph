/*
* Copyright (c) 2020, 2021, Oracle and/or its affiliates. 
*
* Main modules' outputs are defined here, currently ports are fixed, we can use custom values later on
*/

###
# database.tf outputs
###

locals {
  #app_url         = local.is_private ? format("https://%s/graphstudio", oci_database_autonomous_database.private_database.0.connection_urls.0.graph_studio_url) : oci_database_autonomous_database.autonomous_database.0.connection_urls.0.graph_studio_url
  app_url         = local.is_private ? oci_database_autonomous_database.private_database.0.connection_urls.0.graph_studio_url : oci_database_autonomous_database.autonomous_database.0.connection_urls.0.graph_studio_url
  cmd = local.is_private ? tostring( replace(replace("${oci_bastion_session.graph_session.0.ssh_metadata.command}","<","{"),">","}") ): "N/A"

}

output "adb_admin_password" {
  value = random_string.autonomous_database_admin_password.result
}

output "adb_id" {
  value = local.is_private ? oci_database_autonomous_database.private_database.0.id : oci_database_autonomous_database.autonomous_database.0.id
}

output "adb_name" {
  value = local.is_private ? oci_database_autonomous_database.private_database.0.db_name : oci_database_autonomous_database.autonomous_database.0.db_name
}

output "dashboard_url" {
  value = local.app_url
}

output "graph_username" {
  value = local.is_private ? "N/A" : "GRAPHUSER"
}

output "graph_password" {
  value = local.is_private ? "N/A" : random_string.graphuser_password.result
}

output "notes" {
  value = local.is_private ? "Automatic Graph user creation is not available for Private databases" : "Please change the generated passwords on first login"
}

output "connect" {
  value = local.cmd
}

output "private_endpoint" {
  value = local.is_private ? oci_database_autonomous_database.private_database.0.private_endpoint : "N/A"
}
