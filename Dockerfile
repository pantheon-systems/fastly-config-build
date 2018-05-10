FROM golang:1.9

ARG ngrok_zipfile=ngrok-stable-linux-amd64.zip

RUN apt-get update && apt-get install -y unzip dnsutils

# TEMPORARY: include ngrok in our container
RUN mkdir -p ~/.local
RUN curl "https://bin.equinox.io/c/4VmDzA7iaHb/${ngrok_zipfile}" -o "$HOME/.local/${ngrok_zipfile}";
RUN unzip -o "$HOME/.local/${ngrok_zipfile}" -d /usr/local/bin/

EXPOSE 43220 4040

# Install Terraform
RUN curl https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip -o "$HOME/terraform_0.11.7_linux_amd64.zip"
RUN unzip -o "$HOME/terraform_0.11.7_linux_amd64.zip" -d /bin/

# Install the Fastly Terraform provider
WORKDIR /go/src/github.com/terraform-providers
RUN git clone --branch v0.1.4 https://github.com/terraform-providers/terraform-provider-fastly.git

WORKDIR /go/src/github.com/terraform-providers/terraform-provider-fastly
RUN CGO_ENABLED=0 go build -ldflags="-s -w"
COPY /go/src/github.com/terraform-providers/terraform-provider-fastly/terraform-provider-fastly /bin/terraform-provider-fastly

# Install our Terraform assets
ADD terraformrc /root/.terraformrc

RUN mkdir /tf

WORKDIR /tf
