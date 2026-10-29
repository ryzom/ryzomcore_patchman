#!/bin/sh

CMD=$1
DOMAIN=$(pwd|sed s%/home/nevrax/%%)

# the domain runs in a screen session from /home/nevrax/<domain>.screen.rc, or under a
# servdash_cli dashboard from /home/nevrax/<domain>/<domain>.ini when the file
# /home/nevrax/use_servdash exists; the patch applier writes both files
DASHBOARD=screen
if [ -e /home/nevrax/use_servdash ]
then
	DASHBOARD=servdash
fi
SERVDASH=/home/nevrax/bin/servdash_cli
DOMAIN_INI=/home/nevrax/${DOMAIN}/${DOMAIN}.ini

if [ "$CMD" = "" ]
then

    echo
    if [ "$DASHBOARD" = "servdash" ]
    then
        echo Dashboards currently running:
        $SERVDASH --list
    else
        echo Screen sessions currently running:
        screen -list
    fi
    echo
    echo "Commands:"
    echo "  'start' to start the shard"
    echo "  'stop'  to stop the ${DOMAIN}"
    echo "  'join'  to join the ${DOMAIN}'s screen session"
    echo "  'share' to join the screen session in shared mode"
    echo "  'state' to view state information for the ${DOMAIN}"
    echo
    printf "Enter a command: "
    read CMD
fi

if [ "$CMD" = "stop" ]
then
    if [ "$DASHBOARD" = "servdash" ]
    then
	$SERVDASH --shutdown $DOMAIN_INI
	rm -v */*.state
	rm -v */*launch_ctrl ./global.launch_ctrl
    elif [ $(screen -list | grep \\\.${DOMAIN} | wc -l) != 1 ]
    then
	echo Cannot stop domain \'${DOMAIN}\' because no screen by that name appears to be running
	screen -list
    else
	screen -d -r $(screen -list | grep \\\.${DOMAIN}| sed 's/(.*)//') -X quit> /dev/null
	rm -v */*.state
	rm -v */*launch_ctrl ./global.launch_ctrl
    fi
fi

STARTARGS=
SERVDASHARGS=
if [ "$CMD" = "batchstart" ]
then
    STARTARGS='-d -m'
    SERVDASHARGS='-d'
    CMD='start'
fi

if [ "$CMD" = "start" ]
then
	ulimit -c unlimited
	if [ "$DASHBOARD" = "servdash" ]
	then
		# starts the dashboard daemon when none runs, then attaches (batchstart only starts it)
		$SERVDASH $SERVDASHARGS $DOMAIN_INI
	else
		screen -wipe > /dev/null
		if [ $( screen -list | grep \\\.${DOMAIN} | wc -w ) != 0 ]
		then
			echo Cannot start domain \'${DOMAIN}\' because this domain is already started
			screen -list | grep $DOMAIN
		else
		    screen $STARTARGS -S ${DOMAIN} -c /home/nevrax/${DOMAIN}.screen.rc
		fi
	fi
fi

if [ "$CMD" = "join" ]
then
    if [ "$DASHBOARD" = "servdash" ]
    then
    $SERVDASH -a $DOMAIN_INI
    elif [ $(screen -list | grep \\\.${DOMAIN} | wc -l) != 1 ]
    then
    echo Cannot join domain \'${DOMAIN}\' because no screen by that name appears to be running
    screen -list
    else
    screen -r $(screen -list | grep \\\.${DOMAIN}| sed 's/(.*)//')
	fi
fi

if [ "$CMD" = "share" ]
then
    if [ "$DASHBOARD" = "servdash" ]
    then
    # several terminals attach to one dashboard
    $SERVDASH -a $DOMAIN_INI
    elif [ $(screen -list | grep \\\.${DOMAIN} | wc -l) != 1 ]
    then
    echo Cannot join domain \'${DOMAIN}\' because no screen by that name appears to be running
    screen -list
    else
    screen -r -x $(screen -list | grep \\\.${DOMAIN}| sed 's/(.*)//')
	fi
fi

if [ "$CMD" = "state" ]
then
    echo State of domain ${DOMAIN}:
    if [ "$DASHBOARD" = "servdash" ]
    then
    $SERVDASH --status $DOMAIN_INI
    fi
    if [ $(echo */*.state) = "*/*.state" ]
    then
		echo - No state files found
	else
		grep RUNNING *state
	fi
fi
