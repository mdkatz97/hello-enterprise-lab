resource "oci_identity_policy" "hello_platform_access" {
  compartment_id = var.tenancy_ocid
  name           = "hello-platform-role-access"
  description    = "Role and Bastion access for the hello-platform lab."

  statements = [
    "Allow group id ${var.administrators_group_ocid} to manage all-resources in compartment id ${var.compartment_ocid}",

    "Allow group id ${var.developers_group_ocid} to use clusters in compartment id ${var.compartment_ocid}",
    "Allow group id ${var.operators_group_ocid} to use clusters in compartment id ${var.compartment_ocid}",
    "Allow group id ${var.support_group_ocid} to use clusters in compartment id ${var.compartment_ocid}",

    "Allow group id ${var.operators_group_ocid} to read logging-family in compartment id ${var.compartment_ocid}",
    "Allow group id ${var.support_group_ocid} to read logging-family in compartment id ${var.compartment_ocid}",

    "Allow group id ${var.operators_group_ocid} to read metrics in compartment id ${var.compartment_ocid}",
    "Allow group id ${var.support_group_ocid} to read metrics in compartment id ${var.compartment_ocid}",

    "Allow group id ${var.cluster_users_group_ocid} to use bastion in compartment id ${var.compartment_ocid}",

    "Allow group id ${var.cluster_users_group_ocid} to manage bastion-session in compartment id ${var.compartment_ocid} where ALL {target.bastion.ocid='${oci_bastion_bastion.oke.id}', target.bastion-session.type='port_forwarding', target.bastion-session.ip in ['${module.oke.apiserver_private_host}'], target.bastion-session.port='6443'}",

    "Allow group id ${var.cluster_users_group_ocid} to read vcn in compartment id ${var.compartment_ocid}",
    "Allow group id ${var.cluster_users_group_ocid} to read subnet in compartment id ${var.compartment_ocid}"
  ]
}
