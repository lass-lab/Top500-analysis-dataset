#!/bin/bash

rank=10

if [ $# -eq 1 ]; then
  rank="$1"
fi

sqlite="sqlite3 scrap500.db -csv"

sql="select t.time,t.rank,t.system_id,av1.rval as rmax,av2.rval as tpeak, "
sql+="av1.rval/av2.rval as efficiency "
sql+="from (select time,rank,system_id from top500 where rank<=$rank) t "
sql+="inner join (select system_id,rval from sysattr_val where nid=5) av1 "
sql+="on t.system_id=av1.system_id "
sql+="inner join (select system_id,rval from sysattr_val where nid=6) av2 "
sql+="on t.system_id=av2.system_id "
sql+="order by t.time,t.rank"

$sqlite "$sql" | sed 's/"//g'

exit 0

