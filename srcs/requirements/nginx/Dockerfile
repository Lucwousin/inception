FROM alpine:3.16

# Install required packages
RUN apk update && apk upgrade && apk add --no-cache nginx openssl

# Create certificate
RUN mkdir -p /etc/ssl/certs /etc/ssl/private

ARG CERT=/etc/ssl/certs/nginx.crt
ARG PRIVKEY=/etc/ssl/private/nginx.key

RUN openssl req -x509 -newkey rsa:2048 -keyout $PRIVKEY -out $CERT \
    -nodes -days 365 -subj "/C=NL/O=Codam/CN=$DOMAIN/"

ENTRYPOINT nginx -g "daemon off;"
