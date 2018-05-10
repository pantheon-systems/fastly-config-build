FROM golang:1.9
ARG ngrok_zipfile=ngrok-stable-linux-amd64.zip

RUN apt-get update
RUN apt-get install -y unzip
RUN apt-get install -y dnsutils

# TEMPORARY: include ngrok in our container
RUN mkdir -p ~/.local
RUN curl "https://bin.equinox.io/c/4VmDzA7iaHb/${ngrok_zipfile}" -o "$HOME/.local/${ngrok_zipfile}";
RUN unzip -o "$HOME/.local/${ngrok_zipfile}" -d /usr/local/bin/

EXPOSE 43220 4040

WORKDIR /go/src/github.com/terraform-providers
RUN git clone --branch v0.1.4 https://github.com/terraform-providers/terraform-provider-fastly.git

WORKDIR /go/src/github.com/terraform-providers/terraform-provider-fastly
RUN CGO_ENABLED=0 go build -ldflags="-s -w"


FROM hashicorp/terraform:0.10.2
COPY --from=0 /go/src/github.com/terraform-providers/terraform-provider-fastly/terraform-provider-fastly /bin/terraform-provider-fastly

ADD terraformrc /root/.terraformrc

RUN mkdir /tf

WORKDIR /tf
