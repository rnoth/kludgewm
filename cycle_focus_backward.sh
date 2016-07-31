#! /bin/env bash

function switch()
{
	wtf $target 
	chwb -s 3 $target
	chwso -r $target
	focus=$target
}

function interate()
{
	next=`echo "$list" | grep $focus -B 1 | sed 2d`
	if [ -z $next ]; then next=`echo "$list" | head -n 1`; fi
	echo "$next"
}

focus=`pfw`
list=`lsw | sort -r`
target=`interate`

chwb -c 0x808080 -s 3 $focus
switch
target=`interate`
sleep 3
