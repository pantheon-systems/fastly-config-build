[![Docker Repository on Quay](https://quay.io/repository/getpantheon/fastly-config-build/status "Docker Repository on Quay")](https://quay.io/repository/getpantheon/fastly-config-build)

Fastly Config Build
-------------------

This is a simple container that contains Terraform, the Fastly provider for Terraform, and other components needed to build and test the [fastly-config](https://github.com/pantheon-systems/fastly-config) and [fastly-routes](https://github.com/pantheon-systems/fastly-routes) projects.

We setup workdir to be /tf, and you can mount in terraform manifests.

## Building

This repo is built automatically by Quay on every commit that is pushed to the GitHub repository.

## Version

[terraform](https://www.terraform.io/) - 0.12.7
[terraform-provider-fastly](https://www.terraform.io/docs/providers/fastly/index.html) - 0.9.0