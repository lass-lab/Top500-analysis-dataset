#!/bin/bash

sqlite="sqlite3 scrap500.db -csv"

nid=3

for y in `seq 1993 2018`; do
    for m in 6 11; do
        time=$((y*100+m))
        echo $time

        sql="select l.sval as processor from (select system_id,sval from sysattr_val where nid=$nid) l "
        sql+="inner join (select distinct system_id from top500 where time=${time}) t "
        sql+="on l.system_id=t.system_id "
        sql+="order by rmax desc "

        $sqlite "$sql" | tee linpack/rmax/${time}.csv
    done
done


