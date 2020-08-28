#!/bin/bash

sqlite="sqlite3 scrap500.db -csv"

sql="select t1.system_id,min(t2.time),max(t2.time) from "
sql+="(select system_id from system) t1 "
sql+="natural join (select system_id,time from top500 where rank<=10) t2 "
sql+="group by t1.system_id"

$sqlite "$sql"

