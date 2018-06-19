FROM circleci/golang:1.10
USER root

# Declare that we are running in the fastly-config-build container
ENV FASTLY_CONFIG_BUILD 1

#ARG ngrok_zipfile=ngrok-stable-linux-amd64.zip

# Install lsb-release, unzip and dnsutils
RUN apt-get update && apt-get install -y lsb-release unzip dnsutils

# Install gcloud sdk per https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y

# Install kubectl
RUN apt-get install -y kubectl

# TEMPORARY: include ngrok in our container
#RUN mkdir -p ~/.local
#RUN curl "https://bin.equinox.io/c/4VmDzA7iaHb/${ngrok_zipfile}" -o "$HOME/.local/${ngrok_zipfile}";
#RUN unzip -o "$HOME/.local/${ngrok_zipfile}" -d /usr/local/bin/

EXPOSE 43220 4040

# Install Terraform
#RUN curl https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip -o "$HOME/terraform_0.11.7_linux_amd64.zip"
#RUN unzip -o "$HOME/terraform_0.11.7_linux_amd64.zip" -d /bin/
RUN mkdir /tfe-cli
WORKDIR /tfe-cli
RUN git clone https://github.com/hashicorp/tfe-cli.git .

# Install the Fastly Terraform provider
WORKDIR /go/src/github.com/terraform-providers
RUN git clone --branch v0.1.4 https://github.com/terraform-providers/terraform-provider-fastly.git

WORKDIR /go/src/github.com/terraform-providers/terraform-provider-fastly
RUN CGO_ENABLED=0 go build -ldflags="-s -w" && cp /go/src/github.com/terraform-providers/terraform-provider-fastly/terraform-provider-fastly /bin/terraform-provider-fastly

WORKDIR /
RUN rm -rf /go

# Install our Terraform assets
ADD terraformrc /root/.terraformrc

RUN mkdir /tf
WORKDIR /tf
