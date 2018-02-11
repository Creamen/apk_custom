#!/bin/sh

# Very basic stuff to create an empty repo

if [ -z "$1" ]; then
        echo "Usage : $(basename $0) [project_name] [with_hooks]";
        exit 1;
fi

REPO=$1
HOOKS=0

# Create a bare repo
git init -q --bare ${REPO}.git

# Some stuff for cgit
cd ${REPO}.git

git config --local creamen.github-mirror "${REPO}"

shift
if [ "$1" == "with_hooks" -a -d /run/httpd/sites/cgit/hooks ]; then
        # Install our hooks
        ln -sf /run/httpd/sites/cgit/hooks
        HOOKS=1
fi

# https://git-scm.com/docs/gitweb
git config --local gitweb.category "Misc"
git config --local gitweb.description "FEEL FREE TO EDIT ME"
git config --local user.name "David BARON"
git config --local user.email "db@crea.mn"
# Hum not sure it's relevant ...
git config --local core.pager cat
git config --local core.editor vim
echo "readme = info.html" > cgitrc
echo "<div>Change Me !</div>" > info.html
cd - > /dev/null

# Let's rocks baby !
chown -R apache:apache ${REPO}.git

printf "[INFO] Bare git repo %s.git created %s\n[INFO] URL for clone is https://git.creamen.net/%s.git\n" "${REPO}" "$( [ ${HOOKS} == 1 ] && echo ' with git hooks' || echo '' )" "${REPO}";

exit 0;

