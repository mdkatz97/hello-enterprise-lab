module "oke" {
  source  = "oracle-terraform-modules/oke/oci"
  version = "5.5.0"

  providers = {
    oci      = oci
    oci.home = oci.home
  }

  tenancy_ocid   = var.tenancy_ocid
  compartment_id = var.compartment_ocid
  home_region    = var.home_region
  region         = var.region

  state_id = "hello-lab"

  ssh_public_key = var.ssh_public_key

  # The official module creates the OKE service policies and dynamic
  # groups needed by the cluster. The Resource Manager stack is given
  # explicit bootstrap authority in the next phase.
  create_iam_resources = false

  depends_on = [
    oci_identity_policy.oke_cluster_network
  ]

  create_vcn    = true
  vcn_name      = "hello-lab-vcn"
  vcn_dns_label = "hellolab"
  vcn_cidrs     = ["10.20.0.0/16"]

  subnets = {
    bastion = {
      create = "never"
    }

    operator = {
      create = "never"
    }

    cp = {
      cidr      = "10.20.0.0/28"
      is_public = false
    }

    int_lb = {
      create = "never"
    }

    pub_lb = {
      cidr      = "10.20.1.0/24"
      is_public = true
    }

    workers = {
      cidr      = "10.20.2.0/24"
      is_public = false
    }

    pods = {
      create = "never"
    }
  }

  load_balancers          = "public"
  preferred_load_balancer = "public"

  cluster_name       = "hello-lab-oke"
  cluster_type       = "basic"
  kubernetes_version = var.kubernetes_version
  cni_type           = "flannel"

  control_plane_is_public           = false
  assign_public_ip_to_control_plane = false

  # These options would create Compute jump hosts. We use the managed
  # OCI Bastion service instead.
  create_bastion  = false
  create_operator = false

  worker_pool_mode = "node-pool"
  worker_pool_size = 2

  worker_shape = {
    shape            = "VM.Standard.A1.Flex"
    ocpus            = 1
    memory           = 6
    boot_volume_size = 50
  }

  worker_pools = {
    primary = {}
  }

  worker_is_public                  = false
  worker_image_type                 = "oke"
  worker_image_os                   = "Oracle Linux"
  worker_image_os_version           = "8"
  allow_worker_internet_access      = true
  allow_pod_internet_access         = true
  allow_worker_ssh_access           = false
  allow_short_container_image_names = false

  output_detail = false
}
resource "oci_identity_policy" "oke_cluster_network" {
  provider       = oci.home
  compartment_id = var.compartment_ocid
  name           = "oke-cluster-hello-lab-network"
  description    = "Allow the OKE cluster principal to manage NSGs in the lab compartment."

  statements = [
    "Allow any-user to manage network-security-groups in compartment id ${var.compartment_ocid} where request.principal.type = 'cluster'"
  ]
}
