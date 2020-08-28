#!/bin/bash

sqlite="sqlite3 scrap500.db -csv"
sql="select t.time,t.rank,s.system_id,s.name from system s inner join "
sql+="(select time,rank,system_id from top500 where rank<=10) t "
sql+="on s.system_id=t.system_id order by t.time, t.rank"

$sqlite "$sql" | sed 's/"//g' | tee top10.csv

exit 0

#tops=(`cat no1.csv | awk -F, '{print $1}' | sort -u | sed 's/ /_/g'`)
#
#for t in ${tops[@]}; do
#    tt="`echo $t | sed 's/_/ /g'`"
#    lists="`cat no1.csv | grep "^$tt" | awk -F, '{print $2}' | sort -n | paste -sd, -`"
#    echo "$tt:$lists"
#done
#


