#! /bin/sh

trap "rm -f $WEWPIPE; exit 1" INT TERM QUIT EXIT

if [ ! -p $WEWPIPE ]; then
	rm -rf $WEWPIPE
	mkfifo $WEWPIPE
	wew > $WEWPIPE &
fi

switch() {
	wtf $target
	focus=$target
	chwb -c 0x808080 -s 3 $focus
	chwso -r $focus
	echo $focus > TMPDIR/focus.wid
}

while read event; do
	[ ! -f $TMPDIR/focus.wid ] && continue
	focus=`pfw`
	case $event in
		7:*) 
			chwb -c 0x808080 $focus
			target=`echo $event | cut -c 3-`
			switch
		;;
#		16:*)
#			chwb -c 0x808080 $focus
#			target=`echo $event | cut -c 4-`
#			switch
#		;;
		17:*)
			target=`cat $TMPDIR/previous.wid`
			[ -z $target ] && target=`lsw | sort | sed 1q`
			switch
		;;			
	esac
done < $WEWPIPE
