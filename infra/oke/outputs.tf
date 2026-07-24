output "cluster_id" {
  description = "OKE cluster OCID."
  value       = module.oke.cluster_id
}

output "cluster_endpoints" {
  description = "OKE endpoint details."
  value       = module.oke.cluster_endpoints
}

output "control_plane_private_host" {
  description = "Private Kubernetes API address."
  value       = module.oke.apiserver_private_host
}

output "vcn_id" {
  description = "VCN OCID."
  value       = module.oke.vcn_id
}

output "bastion_id" {
  description = "Managed Bastion OCID."
  value       = oci_bastion_bastion.oke.id
}

output "bastion_private_endpoint_ip" {
  description = "Private endpoint address allocated to OCI Bastion."
  value       = oci_bastion_bastion.oke.private_endpoint_ip_address
}
