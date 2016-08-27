#!/bin/sh

[ `lsw | wc -l` = -eq 1 ] && exit 1

switch(){
	echo $1 > $TMPDIR/focus.wid
	wtf $1 
	chwb -s 3 $1
	chwso -r $1
	focus=$1
}

interate(){
	next=`echo "$list" | grep $focus -B 1 | sed 2d`
	[ -z $next ] && next=`echo "$list" | tail -n 1`
	echo $next
}

[ ! -f $TMPDIR/focus.wid ] && exit 1

focus=`cat $TMPDIR/focus.wid`

[ $1 = "forward" ] && list=`lsw | sort`
[ $1 = "backward" ] && list=`lsw | sort -r`

target=`interate`

chwb -c 0x808080 -s $BORDER $focus
echo $focus > $TMPDIR/previous.wid
switch $target
