
resource "null_resource" "sqlcl-create-usr" {

        provisioner "local-exec" {
             command = <<-EOT
                sql -cloudconfig wallet.zip admin/"${random_string.autonomous_database_admin_password.result}"@${var.adb_name}${random_string.deploy_id.result}_high @./scripts/graphs.sql "${random_string.graphuser_password.result}"
                sql -cloudconfig wallet.zip graphuser/"${random_string.graphuser_password.result}"@${var.adb_name}${random_string.deploy_id.result}_high @./scripts/loadcsvfiles.sql 
            EOT
        }


depends_on = [
    local_file.autonomous_database_wallet_file,
  ]

}
