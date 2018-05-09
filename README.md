[![Docker Repository on Quay](https://quay.io/repository/getpantheon/terraform/status "Docker Repository on Quay")](https://quay.io/repository/getpantheon/terraform)

Docker Terraform
----------------

This is a simple container with our customizations built into it.
Entrypoint is inherited from the hashicorp container, and runs terraform.

We setup workdir to be /tf, and you can mount in terraform manifests.

## Building

This repo is built automatically on every commit in Quay, but currently the builds fail because Quay doesn't use a new enough version of Docker that supports multi-stage builds.

To build and deploy to Quay, run `deploy.sh`. This should be automated in CircleCI.

