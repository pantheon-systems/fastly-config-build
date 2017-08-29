Docker Terraform
----------------

This is a simple container with our customizations built into it.
Entrypoint is inherited from the hashicorp container, and runs terraform.

We setup workdir to be /tf, and you can mount in terraform manifests.

Container is published on quay here: https://quay.io/repository/getpantheon/terraform
