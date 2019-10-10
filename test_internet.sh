#!/bin/sh
echo "TEST"
nc -zw1 google.com 443 1> /dev/null 2>&1
exit $?
