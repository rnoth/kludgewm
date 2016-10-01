#! /bin/sh

maxshow(){
	while read window; do
		mapw -m $window
	done < "$TMPDIR/maximize.hid"
}

maxhide(){
	while read window; do
		mapw -u $window
	done < "$TMPDIR/maximize.hid"
}

switch(){
	if [ `lsw | wc -l` -eq 1 ]; then
		mapw -u `cat $TMPDIR/maximize.wid`
		maxshow
		wtf `lsw | sed 1q`
		cat `pfw` > $TMPDIR/focus.wid
	else
		maxhide
		mapw -m `cat $TMPDIR/maximize.wid`
		mv $TMPDIR/focus.wid $TMPDIR/previous.wid
	fi
}

toggle(){
	if [ -e $TMPDIR/maximize.tpl ]; then
		wtp $(cat $TMPDIR/maximize.tpl) `pfw`
		rm $TMPDIR/maximize.tpl
		mv $TMPDIR/maximize.wid $TMPDIR/focus.wid
		maxshow
		rm $TMPDIR/maximize.hid
	else
		lsw | grep -v `pfw` | cat > $TMPDIR/maximize.hid
		maxhide
		wattr xywh `pfw` > $TMPDIR/maximize.tpl
		mv $TMPDIR/focus.wid $TMPDIR/maximize.wid
		root=$(wattr wh `lsw -r`)
		bord=$(wattr b `pfw`);bord="-"$bord" -"$bord
		wtp $bord $root `pfw`
	fi
}

case $1 in 
	toggle)
		toggle
		;;
	switch)
		switch
		;;
esac

