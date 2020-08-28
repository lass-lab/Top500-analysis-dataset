#!/bin/bash

## getting the list of the top5 machines since 2009
top="5"

sqlite="sqlite3 ../scrap500.db -csv"

sql="select s.system_id as id, s.name, "
sql+="      t1.rval as cores,"
sql+="      t2.rval as memory,"
sql+="      t3.rval as rmax "
#sql+="      t4.sval as processor "
sql+="from system s "
sql+="inner join (select system_id,rval from sysattr_val where nid=1) t1 "
sql+=" on s.system_id=t1.system_id "
sql+="inner join (select system_id,rval from sysattr_val where nid=2) t2 "
sql+=" on s.system_id=t2.system_id "
sql+="inner join (select system_id,rval from sysattr_val where nid=5) t3 "
sql+=" on s.system_id=t3.system_id "
#sql+="inner join (select system_id,sval from sysattr_val where nid=3) t4 "
#sql+=" on s.system_id=t4.system_id "
sql+="inner join "
sql+=" (select distinct system_id from top500 where time >= 200900 and rank <= $top) t "
sql+=" on s.system_id=t.system_id "

$sqlite "$sql"

