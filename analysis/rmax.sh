#!/bin/bash

sqlite="sqlite3 scrap500.db -csv"

for y in `seq 1993 2018`; do
    for m in 6 11; do
        time=$((y*100+m))
        echo $time

        sql="select l.rval rmax from (select system_id,rval from sysattr_val where nid=5) l "
        sql+="inner join (select distinct system_id from top500 where time=${time}) t "
        sql+="on l.system_id=t.system_id "
        sql+="order by rmax desc "

        $sqlite "$sql" | tee linpack/rmax/${time}.csv
    done
done


