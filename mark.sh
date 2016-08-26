#!/bin/sh

TEMPDIR=~/tmp

[ -z $1 ] && echo "No enough arguments" && exit 1

mark_window() {
	echo `pfw` > $TEMPDIR/.marks/"$mark".wid
}

list_marks() {
	ls $TEMPDIR/.marks | sed s/.wid//
}

get_wid(){
	cat $TEMPDIR/.marks/"$target".wid
}

if_no_mark(){
	[ $? != 0 ] && echo "mark.sh: $target not found"
}

case $1 in
	mark)
		mark=`list_marks | dmenu -b -p "Mark: "`
		mark_window
		;;
	qmark)
		mark=$2
		mark_window
		;;
	recall)
		target=`list_marks | dmenu -b -p "Recall: "`
		window=`get_wid`
		mapw -m $window
		wtf $window
		if_no_mark
		;;
	qrecall)
		target=$2
		wtf `get_wid`
		if_no_mark
		;;
	unmark)
		target=`list_marks | dmenu -b -p "Unmark: "`
		rm $TEMPDIR/.marks/"$target".wid
		if_no_mark
		;;
	qunmark)
		target=$2
		rm $TEMPDIR/.marks/"$target".wid
		if_no_mark
		;;
	hide)
		target=`list_marks | dmenu -b -p "Hide: "`
		mapw -u `get_wid`
		;;
	qhide)
		target=$2
		mapw -u `cat $TEMPDIR/.marks/"$target".wid`
		;;
esac	
