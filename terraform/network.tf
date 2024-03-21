resource "oci_core_vcn" "simple" {
  count          = local.is_private && local.create_network ? 1 : 0
  cidr_block     = var.vcn_cidr
  dns_label      = substr("${var.vcn_name}", 0, 15)
  compartment_id = var.network_compartment_id
  display_name   = var.vcn_name

  freeform_tags = var.defined_tag.freeformTags
}

#NATW
resource "oci_core_nat_gateway" "simple_nat_gateway" {
  count          = local.is_private && local.create_network ? 1 : 0
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.simple[count.index].id
  display_name   = "${var.vcn_name}-natgw"

  freeform_tags = var.defined_tag.freeformTags
}

#ServiceW
data "oci_core_services" "available_services" { }

resource "oci_core_service_gateway" "simple_service_gateway" {
  count          = local.is_private && local.create_network ? 1 : 0
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.simple[count.index].id
  display_name   = "${var.vcn_name}-svcgw"

  services {
        #Required
        service_id = data.oci_core_services.available_services.services.0.id
    }

  freeform_tags = var.defined_tag.freeformTags
}

#simple subnet
resource "oci_core_subnet" "simple_subnet" {
  count                      = local.is_private && local.create_network ? 1 : 0
  cidr_block                 = var.subnet_cidr
  compartment_id             = var.network_compartment_id
  vcn_id                     = oci_core_vcn.simple[count.index].id
  display_name               = "${var.vcn_name}-subnet"
  dns_label                  = substr("${var.vcn_name}subnet", 0, 15)
  prohibit_public_ip_on_vnic = true

  freeform_tags = var.defined_tag.freeformTags
}

resource "oci_core_route_table" "simple_route_table" {
  count          = local.is_private && local.create_network ? 1 : 0
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.simple[count.index].id
  display_name   = "${var.vcn_name}-rt"

  route_rules {
    network_entity_id = oci_core_nat_gateway.simple_nat_gateway[count.index].id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
  route_rules {
    network_entity_id = oci_core_service_gateway.simple_service_gateway[count.index].id
    destination       = data.oci_core_services.available_services.services.0.cidr_block
    destination_type  = "SERVICE_CIDR_BLOCK"
  }

  freeform_tags = var.defined_tag.freeformTags
}

resource "oci_core_route_table_attachment" "route_table_attachment" {
  count          = local.is_private && local.create_network ? 1 : 0
  subnet_id      = oci_core_subnet.simple_subnet[count.index].id
  route_table_id = oci_core_route_table.simple_route_table[count.index].id
}
