resource "oci_core_network_security_group" "simple_nsg" {
  count = local.is_private? 1 : 0

  #Required
  compartment_id = var.network_compartment_id
  vcn_id         = var.existing_vcn_id

  #Optional
  display_name = "allowGraphBastion"

  freeform_tags = var.defined_tag.freeformTags
}

# Allow HTTPS (TCP port 443) Ingress traffic from the bastion
resource "oci_core_network_security_group_security_rule" "simple_rule_https_ingress" {
  count = local.is_private ? 1 : 0

  network_security_group_id = oci_core_network_security_group.simple_nsg.0.id
  protocol                  = "6"
  direction                 = "INGRESS"
  source                    = "${oci_bastion_bastion.graph_bastion.0.private_endpoint_ip_address}/32"
  stateless                 = false
  source_type               = "CIDR_BLOCK"

  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}

resource "oci_core_network_security_group_security_rule" "simple_rule_db_ingress" {
  count = local.is_private ? 1 : 0

  network_security_group_id = oci_core_network_security_group.simple_nsg.0.id
  protocol                  = "6"
  direction                 = "INGRESS"
  source                    = "${oci_bastion_bastion.graph_bastion.0.private_endpoint_ip_address}/32"
  stateless                 = false
  source_type               = "CIDR_BLOCK"

  tcp_options {
    destination_port_range {
      min = 1521
      max = 1522
    }
  }
}