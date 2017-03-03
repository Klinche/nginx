#!/usr/bin/env bash
set -e

# if command starts with an option, prepend mysqld
if [ "${1:0:1}" = '-' ]; then
	set -- nginx "$@"
fi

if [ "$1" = 'nginx' ]; then
	# Test we're able to startup without errors. We redirect stdout to /dev/null so
	# only the error messages are left.
	result=0
	output=$("$@" --verbose --help 2>&1 > /dev/null) || result=$?
	if [ ! "$result" = "0" ]; then
		echo >&2 'error: could not run nnix. This could be caused by a misconfigured site'
		echo >&2 "$output"
		exit 1
	fi

	if [ -f "$APPFILE" ]; then
       sed -i -e "s/APPFILE/$APPFILE/g" /etc/nginx/sites-available/symfony.conf
    fi

    if [ -f "$URL" ]; then
       sed -i -e "s/URL/$URL/g" /etc/nginx/sites-available/symfony.conf
    fi
fi

exec "$@"
