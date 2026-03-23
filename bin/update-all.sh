#! /bin/sh

WORKDIR=$PWD

for projectdir in $WORKDIR/*
do
    if [ -d "$projectdir"/.git ]
    then
	echo "Updating $projectdir via git"
	cd "$projectdir" || exit 1
	if [ -n "$(git remote)" ]
	then
		time git pull > update.log
		time git gc >> update.log
	else
		echo "Skipping $projectdir (no remote)"
	fi
	echo "Done!"
	echo ""
	cd "$WORKDIR" || exit 1
    fi
done
