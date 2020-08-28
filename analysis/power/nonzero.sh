#!/bin/bash

for file in csv/*.csv; do
  name="`basename $file .csv`"
  cat $file | awk -F, '{ if ($5 > 0) print $0 }' > nonzero/${name}.csv
done

