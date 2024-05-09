#!/bin/bash

d1bright="$(ddcutil -t -d 1 getvcp 10|cut -d " " -f4)"
d2bright="$(ddcutil -t -d 2 getvcp 10|cut -d " " -f4)"

case $1 in
	up)
		ddcutil -d 1 setvcp 10 $((d1bright+10))
		ddcutil -d 2 setvcp 10 $((d2bright+10))
		;;
	down)

		ddcutil -d 1 setvcp 10 $((d1bright-10))
		ddcutil -d 2 setvcp 10 $((d2bright-10))
		;;
	*)
esac
