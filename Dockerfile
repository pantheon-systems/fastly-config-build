FROM cimg/go:1.15
LABEL Description="Pantheon Fastly Build container"
USER root

# Declare that we are running in the fastly-config-build container
ENV FASTLY_CONFIG_BUILD 1

# Install lsb-release, unzip and dnsutils
RUN apt-get update && apt-get install -y lsb-release unzip dnsutils

# Install gcloud sdk per https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y

# Install kubectl
RUN apt-get install -y kubectl

EXPOSE 43220 4040

# Install Terraform
RUN curl https://releases.hashicorp.com/terraform/0.12.7/terraform_0.12.7_linux_amd64.zip -o "$HOME/terraform_0.12.7_linux_amd64.zip"
RUN unzip -o "$HOME/terraform_0.12.7_linux_amd64.zip" -d /bin/

# Install the Fastly Terraform provider
WORKDIR /go/src/github.com/terraform-providers
RUN git clone --branch v0.9.0 https://github.com/terraform-providers/terraform-provider-fastly.git

WORKDIR /go/src/github.com/terraform-providers/terraform-provider-fastly
RUN CGO_ENABLED=0 go build -ldflags="-s -w" && cp /go/src/github.com/terraform-providers/terraform-provider-fastly/terraform-provider-fastly /bin/terraform-provider-fastly_v0.9.0

WORKDIR /
RUN rm -rf /go

RUN mkdir /tf
WORKDIR /tf
