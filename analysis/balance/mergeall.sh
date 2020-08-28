#!/bin/bash

i=0

while read line; do
  id="`echo $line | cut -d, -f3`"
  rec="`cat uniqattr.csv | egrep ^$id, | cut -d, -f2-`"
  seq=$((i/5+1))
  echo $seq,$line,$rec

  ((i++))
done < list.csv | tee recent-top5-balance.csv

# recent-top5-balance.csv
cp recent-top5-balance.csv ../../../plots/recent-top5-balance.csv

# burstbuffer.csv
cat uniqattr.csv | awk -F, -v 'i=1' '{
  if ($21 > 1) {
    printf("%d,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f\n", i,
           ($15+$17),$21,$19, ($16+$18),$22,$20);
    i=i+1;
  }
}' | tee burstbuffer.csv
cp burstbuffer.csv ../../../plots/burstbuffer.csv

