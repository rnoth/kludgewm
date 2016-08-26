#! /bin/sh

if [ -e ~/tmp/`pfw`.max ]; then
	wtp $(cat ~/tmp/`pfw`.max) `pfw`
	rm ~/tmp/`pfw`.max
else
	wattr xywh `pfw` > ~/tmp/`pfw`.max
	root=$(wattr wh `lsw -r`)
	bord=$(wattr b `pfw`);bord="-"$bord" -"$bord
	wtp $bord $root `pfw`
fi