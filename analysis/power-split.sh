#!/bin/bash

i=0

for y in `seq 1993 2018`; do
  for m in 06 11; do
    output="power/$y$m.csv"
    start=$((500*i+1))
    tail -n+$start power.csv | head -n 500 > $output
    i=$((i+1))
  done
done

