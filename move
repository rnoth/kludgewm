#! /bin/sh

[ -n "$X_PAD_LEFT" ] || X_PAD_LEFT=0
[ -n "$Y_PAD_TOP" ] || Y_PAD_TOP=0

FW=`wprnt \`pfw\``
ROOT=`lsw -r`
BORDER=`wattr b $FW`

MAX_X=$(( $(wattr w $ROOT) - 2 * $BORDER))
MAX_Y=$(( $(wattr h $ROOT) - 2 * $BORDER))

win_x=`wattr x $FW`
win_y=`wattr y $FW`
win_w=`wattr w $FW`
win_h=`wattr h $FW`

delta_x=$1
delta_y=$2
delta_w=$3
delta_h=$4
shift 4

x=$(($win_x + $delta_x ))

if [ $(($x + $win_w)) -gt $MAX_X ]; then
	x=$(($MAX_X - $win_w))
elif [ $x -lt $X_PAD_LEFT ]; then
	x=$X_PAD_LEFT
fi

y=$(($win_y + $delta_y))

if [ $(($y + $win_h)) -gt $MAX_Y ]; then
	y=$(($MAX_Y - $win_h))
elif [ $y -lt $Y_PAD_TOP ]; then
	y=$Y_PAD_TOP
fi

w=$(($win_w + $delta_w))

h=$(($win_h + $delta_h))

wtp $x $y $w $h $FW

kludge "$@"
