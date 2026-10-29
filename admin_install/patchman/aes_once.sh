#!/bin/sh -

# One run of the admin executor service of a domain, for the servdash_cli dashboard, which
# restarts it (RestartDelay) and gives it its console (--ctrl, passed through "$@").
# The loop_aes.sh of the screen setup does the same in a loop. Run from the domain directory.

DOMAIN=$(pwd |sed "s%/home/nevrax/%%")

echo AESAliasName= \"aes_$(hostname -s)\"\; > ./aes_alias_name.cfg

if [ $(grep "AESPort[ \t]*=" */*cfg | grep -v debug | sed "s/.*=[ \t]*//" | sort -u | wc -l) != 1 ] ; then echo - FIXME: services don\'t agree on AESPort ; fi
echo AESPort=$(grep "AESPort[ \t]*=" */*cfg| grep -v debug | sed "s/.*=[ \t]*//" | sort -u) >> ./aes_alias_name.cfg

if [ $(grep "ASPort[ \t]*=" */*cfg | grep -v debug | sed "s/.*=[ \t]*//" | sort -u | wc -l) != 1 ] ; then echo - FIXME: services don\'t agree on ASPort ; fi
echo ASPort=$(grep "ASPort[ \t]*=" */*cfg| grep -v debug | sed "s/.*=[ \t]*//" | sort -u) >> ./aes_alias_name.cfg

exec ./live/service_ryzom_admin_service/ryzom_admin_service -A. -C. -L. --nobreak --fulladminname=admin_executor_service --shortadminname=AES "$@"
