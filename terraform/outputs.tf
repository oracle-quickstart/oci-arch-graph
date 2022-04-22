/*
* Copyright (c) 2020, 2021, Oracle and/or its affiliates. 
*
* Main modules' outputs are defined here, currently ports are fixed, we can use custom values later on
*/

###
# database.tf outputs
###

output "adb_admin_password" {
  value = random_string.autonomous_database_admin_password.result
}

output "adb_id" {
  value = oci_database_autonomous_database.autonomous_database.id
}

output "adb_name" {
  value = oci_database_autonomous_database.autonomous_database.db_name
}

output "dashboard_url" {
  value = "${oci_database_autonomous_database.autonomous_database.connection_urls.0.graph_studio_url}"
}

output "graph_username" {
  value = "GRAPHUSER"
}

output "graph_password" {
  value = random_string.graphuser_password.result
}

output "notes" {
  value = "Please change the generated passwords on first login"
}