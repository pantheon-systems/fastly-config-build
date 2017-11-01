FROM golang:1.9

WORKDIR /go/src/github.com/terraform-providers
RUN git clone https://github.com/spheromak/terraform-provider-fastly.git

WORKDIR /go/src/github.com/terraform-providers/terraform-provider-fastly
RUN git checkout integrated-logging-ssl
RUN CGO_ENABLED=0 go build -ldflags="-s -w"


FROM hashicorp/terraform:0.10.9
COPY --from=0 /go/src/github.com/terraform-providers/terraform-provider-fastly/terraform-provider-fastly /bin/terraform-provider-fastly

ADD terraformrc /root/.terraformrc

RUN mkdir /tf

WORKDIR /tf
