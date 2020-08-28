#!/bin/bash

sqlite="sqlite3 scrap500.db -csv"

sql="select s.system_id as id,"
sql+="      t5.time as time, t5.rank as rank, "
sql+="      t1.rval as cores,"
sql+="      t2.rval as memory,"
sql+="      t3.rval as rmax, "
sql+="      t4.sval as processor "
sql+="from system s "
sql+="inner join (select system_id,rval from sysattr_val where nid=1) t1 "
sql+=" on s.system_id=t1.system_id "
sql+="inner join (select system_id,rval from sysattr_val where nid=2) t2 "
sql+=" on s.system_id=t2.system_id "
sql+="inner join (select system_id,rval from sysattr_val where nid=5) t3 "
sql+=" on s.system_id=t3.system_id "
sql+="inner join (select system_id,sval from sysattr_val where nid=3) t4 "
sql+=" on s.system_id=t4.system_id "
sql+="inner join (select time,rank,system_id from top500) t5 "
sql+=" on s.system_id=t5.system_id "
sql+="order by id,time,rank asc"

$sqlite "$sql"

