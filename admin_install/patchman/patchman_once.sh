#!/bin/sh

# One run of the patchman of this host, for the servdash_cli dashboard, which restarts it
# (RestartDelay) and gives it its console (--ctrl, passed through "$@"). It does what one round
# of loop_patchman.sh does for the screen setup: installs a new admin_install.tgz when one
# arrived, picks the configuration of this host from patchman_list, and runs the service.

cd /home/nevrax/
if [ -e /home/nevrax/admin_install.tgz ]
	then
	tar xvzf admin_install.tgz
	chmod 775 bin/admin 2> /dev/null
	chmod 775 bin/ps_services 2> /dev/null
	chmod 775 bin/run_forever 2> /dev/null
	chmod 775 bin/shard 2> /dev/null
	chmod 775 bin/domain_* 2> /dev/null
	chmod 775 bin/startup 2> /dev/null
	chmod 775 bin/servdash_cli 2> /dev/null
	chmod 775 bin/*.sh 2> /dev/null
	chmod 775 patchman/*_service 2> /dev/null
	chmod 775 patchman/*.sh 2> /dev/null
fi

cd /home/nevrax/patchman/
if [ $(grep \ $(hostname)\$ patchman_list |wc -l) -gt 0 ]
	then
	SERVER_TYPE=$(grep \ $(hostname)\$ patchman_list | awk '{ print $1 }')
elif [ $(grep \ $(hostname -s)\$ patchman_list |wc -l) -gt 0 ]
	then
	SERVER_TYPE=$(grep \ $(hostname -s)\$ patchman_list | awk '{ print $1 }')
elif [ $(grep \ $(hostname -d)\$ patchman_list |wc -l) -gt 0 ]
	then
	SERVER_TYPE=$(grep \ $(hostname -d)\$ patchman_list | awk '{ print $1 }')
else
	SERVER_TYPE=default
	echo "ERROR: Neither \'hostname\' \($(hostname)\) nor \'hostname -s\' \($(hostname -s)\) nor \'hostname -d\' \($(hostname -d)\) found in $(pwd)/patchman_list"
fi
CFGFILENAME=patchman_service.${SERVER_TYPE}.cfg

if [ ! -e $CFGFILENAME ]
	then
	echo ERROR: Failed to locate the following file: $CFGFILENAME
	echo using default files
	SERVER_TYPE=default
	CFGFILENAME=patchman_service.${SERVER_TYPE}.cfg
	if [ ! -e $CFGFILENAME ]
		then
		echo ERROR: Failed to locate the following DEFAULT file: $CFGFILENAME
		sleep 10
		exit 1
	fi
fi

echo Using configuration file: $CFGFILENAME
cp $CFGFILENAME patchman_service.cfg

if [ -e core* ]
then
	if [ -e dont_keep_cores ]
	then
		rm core*
	fi
fi

echo Launching patchman...
exec ./ryzom_patchman_service -C. -L. "$@"
