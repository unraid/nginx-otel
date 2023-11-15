# NGINX OpenTelemetry module container

## This repository
This repository contains our fork of [NGINX inc's OpenTelemetry module](https://github.com/nginxinc/nginx-otel). 
This module is useful for using OpenTelemetry tracing in NGINX,
to help keep track of microservice dataflow in production environments.

## Our changes
Our changes to upstream include:
* Improving the CMAKE config to make it build faster on systems that already have GRPC and Protobuf headers installed
* Bundling the module into NGINX inc's
[nginx-unprivileged container image](https://hub.docker.com/r/nginxinc/nginx-unprivileged)
to make a production-ready NGINX container image with OpenTelemetry tracing support.

## Using this container image
This container image is functionally identical to
[nginx-unprivileged](https://hub.docker.com/r/nginxinc/nginx-unprivileged);
The only change is that the `ngx_otel_module.so` module is installed and loaded,
enabling NGINX to send trace data to OpenTelemetry.

Image tags are identical to those published by nginx-unprivileged, we track against the alpine3.18-slim series.
We only build for amd64 architecture.

## Configuring the NGINX OpenTelemetry module
Documentation for configuring the NGINX OpenTelemetry module can be found
[here](https://docs.nginx.com/nginx/admin-guide/dynamic-modules/opentelemetry/).

# License
[Apache License, Version 2.0](https://github.com/unraid/nginx-otel/blob/main/LICENSE)

NGINX is a trademark of F5, inc.

&copy; [F5, Inc.](https://www.f5.com/) 2023
