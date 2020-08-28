#!/bin/bash

if [ $# -ne 1 ]; then
    echo "usage: $0 <field name>"
    exit 1
fi

str="$1"

for f in csv/*.csv; do
    nf=`head -n1 $f | sed -e 's/\(.*\)/\L\1/' -e 's/,/\n/g' -e 's/\"//g' | \
             egrep -n ^$str$ | cut -d: -f1`
    echo "$f: $nf"
done

