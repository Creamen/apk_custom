#!/bin/sh

# Very basic stuff to create an empty repo 

if [ -z "$1" ]; then
	echo "Usage : $(basename $0) [project_name]";
	exit 1;
fi

# Create a bare repo
git init --bare $1.git

# Some stuff for cgit
cd $1.git
# https://git-scm.com/docs/gitweb
git config --local gitweb.category "Misc"
git config --local gitweb.description "FEEL FREE TO EDIT ME"
git config --local user.name "David BARON"
git config --local user.email "db@crea.mn"
# Hum not sure it's relevant ...
git config --local core.pager cat
git config --local core.editor vim
cd - > /dev/null

# Let's rocks baby !
chown -R apache:apache $1.git

exit 0;
