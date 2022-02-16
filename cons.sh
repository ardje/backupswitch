#!/bin/bash
DATADIR=/etc/switches
SWITCHLIST=$DATADIR/switches.txt
THISDIR=$PWD
while read sw ip class password;do
myip="$(ip ro get $ip|awk '/src/ { print $5 }')"
export SW="$sw"
export IP="$ip"
export CLASS="$class"
export MYIP="$myip"
export PASSWORD="$password"
done < <( awk '/'"$1"'[ \t]/ { print $1,$4,$5,$6 }' < $SWITCHLIST )
echo name: $SW ip: $IP myip: $MYIP class: $CLASS
if [ ! -n "$IP" ]; then
	echo "Can't find $1"
fi

exec $THISDIR/expect-cons/$CLASS $IP $SW $MYIP ${PASSWORD/:*/} ${PASSWORD/*:/}
