#!/bin/bash
set -e

if [ "$1" = 'nginx' ]; then
	if [ "$APPFILE" ]; then
       sed -i -e "s/APPFILE/$APPFILE/g" /etc/nginx/sites-available/symfony.conf
    fi

    if [ "$URL" ]; then
       sed -i -e "s/URL/$URL/g" /etc/nginx/sites-available/symfony.conf
    fi
fi

exec "$@"
