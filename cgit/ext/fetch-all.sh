#!/bin/sh

find . -maxdepth 1 -type d -name '*.git' \
        | while read repo; do \
        cd ${repo} > /dev/null;
        grep -Eq '(ssh|http(s)?|git)://' <<< "$(git remote -v)" \
                && echo "Update ${repo} ... " \
                && git fetch --all -q \
                && ( [ "$1" = "gc" ] && git gc --aggressive ) \
                && chown -R apache:apache .;    \
        cd - > /dev/null;       \
        chown apache:apache ${repo};    \
        done

if [ -d linux-docs ]; then
	cd linux-docs && git pull --progress  --depth 1 origin master
fi

