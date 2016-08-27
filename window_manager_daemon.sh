#!/bin/sh

# TODO:
# add the code to be able to start/stop individual daemons

[ -z $2 ] && echo No enough arguments && exit 1

trap "reload all" HUP
trap "stop all" INT TERM

idle(){
	while true; do sleep 1000; done
}

start(){
	if [ $1 = 'all' ]; then
		sxhkd &
		SXHKD_PID=$!
		rainbow.sh &
		RAINBOW_PID=$!
		autofocus.sh &
		AUTOFOCUS_PID=$!
		return 0
	else
		echo Feature not implemented && exit 1
		#exec $1
	fi
}

reload(){
	case $1 in
		all)
			kill $SXHKD_PID
			sxhkd &
			SXHKD_PID=$!
			
			kill $RAINBOW_PID
			rainbow.sh &
			RAINDBOW_PID=$!

			kill $AUTOFOCUS_PID
			autofocus.sh &
			AUTOFOCUS_PID=$!
			;;
		autofocus.sh)
			kill $AUTOFOCUS_PID 
			autofocus.sh &
			AUTOFOCUS_PID=$!
			;;
		rainbow.sh)
			kill $RAINBOW_PID
			rainbow.sh &
			RAINDBOW_PID=$!
			;;
		sxhkd)
			kill $SXHKD_PID
			sxhkd &
			SXHKD_PIC=$!
			;;
	esac
}
		
stop(){
	if [ $1 = 'all' ]; then
		pkill rainbow.sh
		pkill autofocus.sh
		pkill sxhkd
	else
		echo Feature not implemented && exit 1
	fi
	
	exit 0
}

case $1 in
	start)
		start $2
		idle
		;;
	*)
		exit 1
		;;
esac
