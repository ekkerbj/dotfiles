#! /bin/sh
find . -type f -name "*~" -print | while read i
do
    echo $i
    rm -f $i
done
