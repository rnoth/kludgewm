#! /bin/sh

FW=`pfw`
ROOT=`lsw -r`
BORDER=`wattr b $FW`

MAX_X=$(expr `wattr x $ROOT` - $BORDER)
MAX_Y=$(expr `wattr y $ROOT` - $BORDER)

win_x=`wattr x $FW`
win_y=`wattr y $FW`
win_h=`wattr h $FW`
win_w=`wattr w $FW`

delta_x=$1
delta_y=$2
delta_h=$3
delta_w=$4

x=`expr $win_x + $delta_x`

#if [ `expr $x + $win_w` -gt $MAX_X ]; then
#	x=`expr $MAX_X - $win_w`
#elif [ $x -lt 0 ]; then
#	x=3
#fi

y=`expr $win_y + $delta_y`

#if [ `expr $y + $win_y` -gt $MAX_Y ]; then
#	y=`expr $MAX_Y - $win_h`
#elif [ $y -lt 0 ]; then
#	y=3
#fi

wtp $x $y $win_w $win_h $FW
