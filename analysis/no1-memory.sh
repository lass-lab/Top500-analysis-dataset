#!/bin/bash

sqlite="sqlite3 scrap500.db -csv"
sql="select t.time,s.name from system s inner join "
sql+="(select time,system_id from top500 where rank=1) t "
sql+="on s.system_id=t.system_id order by t.time"

$sqlite "$sql"

