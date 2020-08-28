#!/bin/bash

mkdir -p rank

for id in `cat id.csv`; do
  sql="select time,rank from top500 where system_id=$id and time > 200900 and rank <=5"
  sqlite3 ../scrap500.db -csv "$sql" > rank/${id}.csv

  echo -n "$id"

  for year in `seq 2009 2018`; do
    for month in "06" "11"; do
      list="$year$month"
      file="rank/${id}.csv"
      pos="`grep $list $file | cut -d, -f2`"
      echo -n ",$pos"
    done
  done
  echo
done
