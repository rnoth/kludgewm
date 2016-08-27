#!/bin/sh

[ ! -p $WEWPIPE ] && exit 1

dmenu_path | dmenu -b -p "Spawn:" "$@" | ${SHELL} &
mv $TMPDIR/focus.wid $TMPDIR/previous.wid
child=`lsw | tac | sed 1q`
wtf $child
chwb -s 3 $child
chwso -r $child
echo $child > $TMPDIR/focus.wid
