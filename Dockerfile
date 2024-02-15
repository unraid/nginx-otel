FROM docker.io/library/alpine:3.18.4 as otel-module-builder

WORKDIR /opt

RUN apk add \
    cmake build-base openssl-dev zlib-dev pcre-dev \
    pkgconfig c-ares-dev re2-dev \
    grpc-dev protobuf-dev \
    git unzip

ADD https://github.com/nginx/nginx/archive/refs/tags/release-1.25.3.zip .
RUN unzip release-1.25.3.zip; mv nginx-release-1.25.3 nginx
WORKDIR /opt/nginx
RUN auto/configure --with-compat

COPY . /opt/nginx-otel/
WORKDIR /opt/nginx-otel/build
RUN cmake -DNGX_OTEL_NGINX_BUILD_DIR=/opt/nginx/objs ..
RUN make -j 8

FROM docker.io/nginxinc/nginx-unprivileged:1.25.4-alpine3.18-slim

USER 0
RUN apk add --no-cache grpc grpc-cpp
COPY --from=otel-module-builder /opt/nginx-otel/build/ngx_otel_module.so /etc/nginx/modules/
RUN echo "load_module modules/ngx_otel_module.so;$(cat /etc/nginx/nginx.conf)" > /etc/nginx/nginx.conf
USER 101
