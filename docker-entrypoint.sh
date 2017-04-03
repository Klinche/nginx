#!/bin/bash
set -e

if [ "$1" = 'nginx' ]; then
	if [ "$APPFILE" ]; then
       sed -i -e "s/APPFILE/$APPFILE/g" /etc/nginx/conf.d/symfony.conf
    fi

    if [ "$URL" ]; then
       sed -i -e "s/URL/$URL/g" /etc/nginx/conf.d/symfony.conf
    fi
fi

if [ "$WAIT_FOR_PHP" == "true" ]; then
    while true
    do
      [ -f .php_setup ] && break
      sleep 2
    done
fi

exec "$@"
