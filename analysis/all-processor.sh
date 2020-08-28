#!/bin/bash

i=1

last_id='no'

while read in; do
  id="`echo $in | cut -d, -f1`"

  if [ "$last_id" == "$id" ]; then
    continue
  fi

  last_id="$id"

  cpustr=`echo "$in" | gawk -F, '{print $NF}' | sed 's/"//g'`
  echo $i,$cpustr
  ((i++))
done < all-attr.csv

