#!/bin/sh
if [ -f ~/tmp/hiden.wid ]; then
	mapw -m `cat ~/tmp/hiden.wid`
	wtf `cat ~/tmp/hiden.wid`
	chwso -r `pfw`
else	
	echo `pfw` > ~/tmp/hiden.wid
	mapw -u `pfw`
	if [ -f ~/tmp/previous.wid ]; then
		target=`cat ~/tmp/previous.wid`
		echo `pfw` > ~/tmp/previous.wid
		wtf $target
	else
		echo `pfw` > ~/tmp/previous.wid
		wtf `lsw | sort -r | head -n 1`
	fi
fi