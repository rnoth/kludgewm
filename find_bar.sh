#! /bin/sh

for window in `lsw`; do
	echo $window `wname $window`
	if [ "`wname $window`" = 'bar' ]; then
		echo "$window" > ~/tmp/ignore.wid
		echo found it
	fi
done