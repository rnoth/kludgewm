#!/bin/sh

switch()
{
	wtf $target 
	chwb -s 3 $target
	chwso -r $target
	focus=$target
}

interate()
{
	next=`echo "$list" | grep $focus -B 1 | sed 2d`
	if [ -z $next ]; then next=`echo "$list" | head -n 1`; fi
	echo "$next"
}

focus=`pfw`
[ $1 = "forward" ] && list=`lsw | sort`
[ $1 = "backward" ] && list=`lsw | sort -r`

if [ -e ~/tmp/ignore.wid ]; then
	ignore=`cat ~/tmp/ignore.wid` 
	list=`echo "$list" | sed /"$ignore"/d`
fi

target=`interate`

chwb -c 0x808080 -s 3 $focus
switch
