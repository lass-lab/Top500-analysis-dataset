#!/bin/bash

i=0

while read line; do
  id="`echo $line | cut -d, -f3`"
  rec="`cat uniqattr.csv | egrep ^$id, | cut -d, -f2-`"
  seq=$((i/5+1))
#  echo $seq,$line,$rec
  echo $rec

  ((i++))
done < list.csv
