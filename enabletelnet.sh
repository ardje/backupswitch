#!/bin/bash -x

# enable telnet on gs724tv4 class of switches
IP="$1"
CN="-g -c cookie.txt"
C="-b cookie.txt $CN"
PW="password"
socat TCP6-LISTEN:55432,fork,reuseaddr TCP:[$IP]:80 &
PID=$!
rm cookie.txt
curl $CN http://[::1]:55432/
curl $C -d "pwd=$PW" http://[::1]:55432/base/cheetah_login.html
curl $C --data 'v_1_1_1=Enable&v_1_1_1=Enable&submit_flag=8&submit_target=telnetSmart.html&err_flag=0&err_msg=&clazz_information=telnetSmart.html&v_2_1_2=APPLY'  http://[::1]:55432/telnetSmart.html/a1
rm cookie.txt
kill $PID
