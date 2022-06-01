#!/bin/bash -x
LL="$1"
CURL_VERSION="$(curl -V|awk '{ print $2; nextfile}')"
USE_INTERFACE=false
USE_BRACKETS=true
case "$CURL_VERSION" in
	7.35.*)
		USE_BRACKETS=false
		USE_INTERFACE=false
		;;
	7.64.*)
		USE_INTERFACE=true
		;;
esac


ARGS="cmd=home_login&dummy=1000000000000"
BJ4="$(echo -n "$ARGS"|md5sum|awk '{ print $1 }')"
SCOPE="${LL/*\%25/}"
if [ "$SCOPE" = "$LL" ]; then
	SCOPE="${LL/*\%/}"
	if [ "$SCOPE" = "$LL" ]; then
		SCOPE=""
	fi
fi	
if $USE_INTERFACE; then
	if [ -n "$SCOPE" ]; then
		INTERFACE="--interface $SCOPE"
		LL="${LL/\%*/}"
	fi
fi
if $USE_BRACKETS; then
	LL="[${LL}]"
fi

# netcat needs openbsd-netcat due to broken netcat in debian
#echo -en 'GET /cgi/get.cgi?'"$ARGS&bj4=$BJ4"' HTTP/1.0\r\n\r\n'|nc "$LL" 80|awk '/"sn":/ { print $2 }'
curl -g $INTERFACE -H "Host: dumbdumb" "http://$LL/cgi/get.cgi?$ARGS&bj4=$BJ4"
