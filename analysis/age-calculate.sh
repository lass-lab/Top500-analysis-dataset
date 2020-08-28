#!/bin/bash

#cat age-all.csv | gawk -F, '{ \
cat age-top10.csv | gawk -F, '{ \
  id=$1; \
  minyear=substr($2,1,4); \
  minmon=substr($2,5); \
  maxyear=substr($3,1,4); \
  maxmon=substr($3,5); \
  mons=1+(maxmon-minmon)+(maxyear-minyear)*12; \
  print id,$2,$3,mons; \
}'

