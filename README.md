[![Docker Repository on Quay](https://quay.io/repository/getpantheon/terraform/status "Docker Repository on Quay")](https://quay.io/repository/getpantheon/terraform)

Docker Terraform
----------------

This is a simple container with our customizations built into it.
Entrypoint is inherited from the hashicorp container, and runs terraform.

We setup workdir to be /tf, and you can mount in terraform manifests.

## Building

This repo is built automatically by Quay on every commit that is pushed to the GitHub repository.
