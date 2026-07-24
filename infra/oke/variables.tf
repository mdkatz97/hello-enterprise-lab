variable "tenancy_ocid" {
  description = "OCI tenancy OCID."
  type        = string
}

variable "compartment_ocid" {
  description = "OCID of the hello-platform compartment."
  type        = string
}

variable "region" {
  description = "OCI region identifier for the lab."
  type        = string
}

variable "home_region" {
  description = "OCI tenancy home-region identifier."
  type        = string
}

variable "kubernetes_version" {
  description = "Currently supported OKE Kubernetes version, including leading v."
  type        = string
}

variable "admin_source_cidr" {
  description = "Current public IPv4 source address in /32 notation."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.admin_source_cidr))
    error_message = "admin_source_cidr must be valid CIDR notation."
  }
}

variable "ssh_public_key" {
  description = "Public SSH key only. Never provide the private key."
  type        = string
}

variable "administrators_group_ocid" {
  type = string
}

variable "developers_group_ocid" {
  type = string
}

variable "operators_group_ocid" {
  type = string
}

variable "support_group_ocid" {
  type = string
}

variable "cluster_users_group_ocid" {
  type = string
}
