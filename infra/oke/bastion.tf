resource "oci_core_security_list" "managed_bastion" {
  compartment_id = var.compartment_ocid
  vcn_id         = module.oke.vcn_id
  display_name   = "hello-managed-bastion-sl"

  egress_security_rules {
    destination = module.oke.control_plane_subnet_cidr
    protocol    = "6"
    stateless   = false

    tcp_options {
      min = 6443
      max = 6443
    }
  }
}

resource "oci_core_subnet" "managed_bastion" {
  compartment_id             = var.compartment_ocid
  vcn_id                     = module.oke.vcn_id
  cidr_block                 = "10.20.3.0/28"
  display_name               = "hello-managed-bastion"
  dns_label                  = "bastion"
  prohibit_public_ip_on_vnic = true

  route_table_id    = module.oke.nat_route_table_id
  security_list_ids = [oci_core_security_list.managed_bastion.id]
}

resource "oci_bastion_bastion" "oke" {
  bastion_type     = "standard"
  compartment_id   = var.compartment_ocid
  target_subnet_id = oci_core_subnet.managed_bastion.id

  client_cidr_block_allow_list = [
    var.admin_source_cidr
  ]

  max_session_ttl_in_seconds = 3600
  name                       = "HelloLabOKE"
}

resource "oci_core_network_security_group_security_rule" "bastion_to_api" {
  network_security_group_id = module.oke.control_plane_nsg_id

  direction   = "INGRESS"
  protocol    = "6"
  source      = "${oci_bastion_bastion.oke.private_endpoint_ip_address}/32"
  source_type = "CIDR_BLOCK"
  stateless   = false

  tcp_options {
    destination_port_range {
      min = 6443
      max = 6443
    }
  }
}
