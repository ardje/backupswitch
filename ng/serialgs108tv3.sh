#!/bin/bash -x
LL="$1"
ARGS="cmd=home_login&dummy=1000000000000"
BJ4="$(echo -n "$ARGS"|md5sum|awk '{ print $1 }')"
echo -en 'GET /cgi/get.cgi?'"$ARGS&bj4=$BJ4"' HTTP/1.0\r\n\r\n'|nc "$LL" 80|awk '/"sn":/ { print $2 }'
