#! /bin/sh

wewpipe=~/tmp/wew

trap "rm -f $wewpipe; exit 1" INT HUP TERM QUIT EXIT

if [ ! -p $wewpipe ]; then
	rm -rf $wewpipe
	mkfifo $wewpipe
	wew > $wewpipe &
fi

switch() {
	wtf $target
	focus=$target
	chwb -c 0x808080 -s 3 $focus
	chwso -r $focus
}

while read event; do
	focus=`pfw 2&> /dev/null`
	echo $event
	case $event in
		7:*) 
			chwb -c 0x808080 $focus
			target=`echo $event | cut -c 3-`
			switch
		;;
		16:*)
			chwb -c 0x808080 $focus
			target=`echo $event | cut -c 4-`
			switch
		;;
		17:*)
			target=`lsw | sort | sed 1q`
			switch
		;;			
	esac
done < $wewpipe
