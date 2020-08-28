#!/bin/bash

rank=500

if [ $# -eq 1 ]; then
  rank="$1"
fi

sqlite="sqlite3 scrap500.db -csv"

sql="select t.time,t.rank,t.system_id,av0.rval as rmax,"
sql+="av1.rval as power,av2.rval as pml "
sql+="from (select time,rank,system_id from top500 where rank<=$rank) t "
sql+="inner join (select system_id,rval from sysattr_val where nid=5) av0 "
sql+="on t.system_id=av0.system_id "
sql+="inner join (select system_id,rval from sysattr_val where nid=10) av1 "
sql+="on t.system_id=av1.system_id "
sql+="inner join (select system_id,rval from sysattr_val where nid=11) av2 "
sql+="on t.system_id=av2.system_id "
sql+="order by t.time,t.rank"

$sqlite "$sql" | sed 's/"//g'

exit 0


