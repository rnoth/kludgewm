#! /bin/sh

FW=`pfw`
ROOT=`lsw -r`
BORDER=`wattr b $FW`

MAX_X=$(expr `wattr w $ROOT` - 2 \* $BORDER)
MAX_Y=$(expr `wattr h $ROOT` - 2 \* $BORDER)

win_x=`wattr x $FW`
win_y=`wattr y $FW`
win_w=`wattr w $FW`
win_h=`wattr h $FW`

delta_x=$1
delta_y=$2
delta_w=$3
delta_h=$4
shift 4

x=`expr $win_x + $delta_x`

if [ `expr $x + $win_w` -gt $MAX_X ]; then
	x=`expr $MAX_X - $win_w`
elif [ $x -lt $X_PAD_LEFT ]; then
	x=$X_PAD_LEFT
fi

y=`expr $win_y + $delta_y`

if [ `expr $y + $win_h` -gt $MAX_Y ]; then
	y=`expr $MAX_Y - $win_h`
elif [ $y -lt $Y_PAD_TOP ]; then
	y=$Y_PAD_TOP
fi

w=`expr $win_w + $delta_w`

h=`expr $win_h + $delta_h`

wtp $x $y $w $h $FW

kludge "$@"
