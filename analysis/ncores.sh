#!/bin/bash

while read in; do
  cores="`echo $in | egrep -o ' [1-9][0-9]?C '`"

  if [ -z "$cores" ]; then
    cores="1"
  fi

  echo "$cores" | awk '{print $1}' | sed 's/C$//'
done < cpus.csv
