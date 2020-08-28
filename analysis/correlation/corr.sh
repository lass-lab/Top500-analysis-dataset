#!/bin/bash

i=1

for file in list/*.csv; do
  time="`basename $file .csv`"
  echo -n "$i,$time,"
  Rscript -e 'd<-read.csv("stdin",header=F,sep=","); cat(cor(d$V5,d$V3),cor(d$V5,d$V6),cor(d$V5,d$V7),cor(d$V5,d$V4),"\\n");' 2>/dev/null < $file | \
        gsed 's/ /,/g' | gsed 's/,$//' | gsed 's/NA//g'
  i=$((i+1))
done

