#!/bin/sh

if [ "$COMPOSE_PROFILES" != "" ] && [ ! -d /data/wordpress/static ]; then
  mkdir -p /data/wordpress/static
  tar xzf /website.tar.gz --directory /data/wordpress/static
fi

exec nginx -g "daemon off ;"

