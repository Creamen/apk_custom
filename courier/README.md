== Hack ==

`find bin -type f -perm /u+x -exec ldd {} 2> /dev/null \;  | grep -oE '/tmp/[^ ]+' | sed s,tmp,usr, | sort  -u`

