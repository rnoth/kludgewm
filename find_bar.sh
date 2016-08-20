#! /bin/sh

for window in `lsw`; do
	if [ "`wname "$window"`" = 'bar' ]; then
		echo "$window" > ~/tmp/ignore.wid
	fi
done