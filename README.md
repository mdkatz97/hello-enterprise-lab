# Hello Enterprise Lab

A production-pattern learning environment for deploying a hardened
static web page to Oracle Kubernetes Engine.

## Local workstation

- Windows
- WSL2 OracleLinux_9_5
- Rancher Desktop Moby/dockerd
- Rancher Desktop Kubernetes

## Cloud design

- OCI Free Tier resources where available
- OKE Basic with private API and private workers
- OCI managed Bastion
- Terraform and OCI Resource Manager
- GitHub Actions and public GHCR
- FluxCD GitOps
- Envoy Gateway
- cert-manager
- OCI IAM and Kubernetes RBAC

## Deliberate limitation

The strict-free OKE Basic design uses Flannel and does not claim
Kubernetes NetworkPolicy enforcement.
