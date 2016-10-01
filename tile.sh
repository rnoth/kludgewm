#!/bin/sh

master=`pfw` || exit 1
test -n $1 || master=$1

stack=`lsw | grep -v $master`

rooth=$(wattr h `lsw -r`)
rootw=$(wattr w `lsw -r`)

wtp 0 0 $(e ${rootw}/2) \
	$(e ${rooth}-2*$(wattr b `pfw`) ) \
	$master 

nn=`echo "$stack" | wc -l`
div=$(e $(wattr h `lsw -r`)/${nn})
printf "%s\n" $div
cnt=-1
for window in $stack; do
	cnt=$(e $cnt+1)
	wtp 	$(e `wattr w $master`+`wattr b $window`+`wattr b $master`) \
		$(e ${div}*${cnt}) \
		$(e `wattr w $master`-4*`wattr b $window`) \
		$(e ${div}-2*`wattr b $window`) \
		$window

done
