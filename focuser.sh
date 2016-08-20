#! /bin/sh

wewpipe=~/temp/wew

trap "rm -f $wewpipe" INT HUP TERM QUIT EXIT

if [ ! -p $wewpipe ]; then
	rm -rf $wewpipe
	mkfifo $wewpipe
	wew > $wewpipe &
fi

switch() {
	chwb -c 0x808080 $focus
	echo "$focus" > ~/temp/previous.wid
	wtf $target
	focus=`pfw`
	chwb -c 0x808080 -s 3 $focus
	chwso -r $focus

	echo "$event"
	echo "$target"
}

while read event; do
	focus=`pfw`
	echo $event
	case $event in
		16:*) 
			target=`echo $event | cut -c 4-`
			switch
		;;
		17:*)
			target=`more ~/temp/previous.wid`
			switch
		;;			
	esac
done < $wewpipe