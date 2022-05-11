#!/bin/bash -x
LL="$1"
KEY="$2"
DATA="{\"_ds=1&pwd=&actKeyText=$KEY&xsrf=undefined&_de=1\":{}}"
ARGS="cmd=sys_activationKey&dummy=1000000000000"
BJ4="$(echo -n "$ARGS"|md5sum|awk '{ print $1 }')"
SCOPE="${LL/*\%25/}"
if [ "$SCOPE" = "$LL" ]; then
	SCOPE="${LL/*\%/}"
	if [ "$SCOPE" = "$LL" ]; then
		SCOPE=""
	fi
fi	
if [ -n "$SCOPE" ]; then
	INTERFACE="--interface $SCOPE"
	LL="[${LL/\%*/}]"
fi

# netcat needs openbsd-netcat due to broken netcat in debian
#echo -en 'GET /cgi/get.cgi?'"$ARGS&bj4=$BJ4"' HTTP/1.0\r\n\r\n'|nc "$LL" 80|awk '/"sn":/ { print $2 }'
curl $INTERFACE --data "$DATA" "http://$LL/cgi/set.cgi?$ARGS&bj4=$BJ4"
