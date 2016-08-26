#! /bin/sh

BAR_FIFO=~/tmp/bar.fifo

[ -e "$BAR_FIFO" ] && rm "$BAR_FIFO"
mkfifo "$BAR_FIFO"

cmus-playing.sh "M" > $BAR_FIFO &
while true; do echo "B"`battery`; sleep 1m; done > $BAR_FIFO &
while true; do date +T%H:%M:%S; sleep 1; done > $BAR_FIFO &

while read -r event; do

	case $event in
		T*)
			time=${event#T}
			;;
		M*)
			song=${event#M}
			;;		
		B*)
			charge=${event#B}
			;;
		*)
			;;
	esac
			
	echo %{r}$song" | "$charge" | "$time" "
done < "$BAR_FIFO" | lemonbar 
