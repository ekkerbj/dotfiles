#!/bin/sh

WORKDIR=$PWD

for projectdir in "$WORKDIR"/*
do
  if [ -d "$projectdir"/.git ]
  then
    echo "Updating $projectdir with Git"
    cd "$projectdir"
    if [ -n "$(git remote)" ]
    then
        git pull > update.log 2>&1
        git gc >> update.log 2>&1
    else
        echo "Skipping $projectdir: no Git remote configured"
    fi
    echo "Done!"
    echo ""
    cd "$WORKDIR"
  fi
done

