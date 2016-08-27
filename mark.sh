#!/bin/sh

[ -z $1 ] && echo "No enough arguments" && exit 1
[ ! -e $TMPDIR/.marks ] && mkdir $TMPDIR/.marks

mark_window() {
	echo `pfw` > $TMPDIR/.marks/"$mark".wid
}

list_marks() {
	ls $TMPDIR/.marks | sed s/.wid//
}

get_wid(){
	cat $TMPDIR/.marks/"$target".wid
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
		rm $TMPDIR/.marks/"$target".wid
		if_no_mark
		;;
	qunmark)
		target=$2
		rm $TMPDIR/.marks/"$target".wid
		if_no_mark
		;;
	hide)
		target=`list_marks | dmenu -b -p "Hide: "`
		mapw -u `get_wid`
		;;
	qhide)
		target=$2
		mapw -u `cat $TMPDIR/.marks/"$target".wid`
		;;
esac	
