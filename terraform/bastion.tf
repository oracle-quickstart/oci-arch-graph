resource "oci_bastion_bastion" "graph_bastion" {
    count = local.is_private? 1 : 0
    #Required
    bastion_type = "standard"
    compartment_id = var.network_compartment_id
    target_subnet_id = local.create_network ? oci_core_subnet.simple_subnet.0.id : var.subnet_id

    #Optional
    client_cidr_block_allow_list = var.cidr_allowlist
    max_session_ttl_in_seconds = var.max_ttl * 60
    name = var.bastion_name

    freeform_tags = var.defined_tag.freeformTags
}


resource "oci_bastion_session" "graph_session" {
    count = local.is_private? 1 : 0
    #Required
    bastion_id = oci_bastion_bastion.graph_bastion.0.id
    key_details {
        #Required
        public_key_content = var.ssh_public_key
    }
    target_resource_details {
        #Required
        session_type = "PORT_FORWARDING"

        #Optional
        target_resource_port = "443"
        target_resource_private_ip_address = oci_database_autonomous_database.private_database.0.private_endpoint_ip
    }

    #Optional
    display_name = "adbGraphStudio"
    session_ttl_in_seconds = var.max_ttl * 60
}

resource "oci_bastion_session" "adb_session" {
    count = local.is_private? 1 : 0
    #Required
    bastion_id = oci_bastion_bastion.graph_bastion.0.id
    key_details {
        #Required
        public_key_content = var.ssh_public_key
    }
    target_resource_details {
        #Required
        session_type = "PORT_FORWARDING"

        #Optional
        target_resource_port = "1522"
        target_resource_private_ip_address = oci_database_autonomous_database.private_database.0.private_endpoint_ip
    }

    #Optional
    display_name = "adbGraphDatabase"
    session_ttl_in_seconds = var.max_ttl * 60
}