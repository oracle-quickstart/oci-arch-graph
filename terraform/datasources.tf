/*
* Copyright (c) 2022, Oracle and/or its affiliates. 
 */

# Randoms
resource "random_string" "deploy_id" {
  length  = 4
  special = false
}

resource "random_string" "autonomous_database_admin_password" {
  length           = 16
  special          = true
  min_upper        = 3
  min_lower        = 3
  min_numeric      = 3
  min_special      = 1
  override_special = "#"
}

resource "random_string" "graphuser_password" {
  length           = 12
  special          = true
  min_upper        = 3
  min_lower        = 3
  min_numeric      = 3
  min_special      = 1
  override_special = "#"
}