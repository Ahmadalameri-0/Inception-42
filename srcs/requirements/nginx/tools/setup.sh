#!/bin/bash

set -e

mkdir -p /etc/ssl/private
mkdir -p /etc/ssl/certs

openssl req -x509 -nodes \
    -out /etc/ssl/certs/inception.crt \
    -keyout /etc/ssl/private/inception.key \
    -subj "/C=JO/ST=Amman/L=Amman/O=42/CN=${DOMAIN_NAME}" \
    -days 365

exec nginx -g "daemon off;"