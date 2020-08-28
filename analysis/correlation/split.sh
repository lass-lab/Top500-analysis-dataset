#!/bin/bash

#for y in `seq 1993 2018`; do
#  cat all-supercomputers-year.csv | cut -d, -f2- | grep "^$y" > ${y}.csv
#done

for y in `seq 1993 2018`; do
  for l in 06 11; do
    list="$y$l"
    cat all-supercomputers-year.csv | cut -d, -f2- | grep "^$list" > list/${list}.csv
  done
done

