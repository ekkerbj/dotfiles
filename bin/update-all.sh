#! /bin/sh

WORKDIR=$PWD

for projectdir in $WORKDIR/*
do
    if [ -d "$projectdir"/.git ]
    then
	echo "Updating $projectdir via git"
	cd $projectdir
	time git pull > update.log
	time git gc >> update.log
	echo "Done!"
	echo ""
	cd $WORKDIR
    fi
done
