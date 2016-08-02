#! /bin/sh

if [ -e ~/temp/`pfw`.max ]; then
	wtp $(cat ~/temp/`pfw`.max) `pfw`
	rm ~/temp/`pfw`.max
else
	wattr xywh `pfw` > ~/temp/`pfw`.max
	root=$(wattr wh `lsw -r`)
	bord=$(wattr b `pfw`);bord="-"$bord" -"$bord
	wtp $bord $root `pfw`
fi