#!/bin/sh

read _in

if [ "$(echo -n "$_in" | grep -Eq '^[0-9]+$' || echo -n err)" = "err" ]; then
	cat users/default.txt
	exit 0
fi

[ -f users/${_in}.txt ] && cat users/${_in}.txt || cat users/default.txt

exit 0
