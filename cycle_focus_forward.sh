#! /bin/env bash
focus=`pfw`
target=`lsw | grep $focus -B 1 | sed 1d`
if [ -z "$target" ]; then target=`lsw | tail -n 1`; fi
wtf $target 