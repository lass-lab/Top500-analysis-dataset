#!/bin/bash

if [ $# -ne 1 ]; then
  echo "usage: $0 <system name>"
  exit
fi

name="$1"

sqlite="sqlite3 scrap500.db -csv"

sql="select t.time,t.rank,t.system_id,s.name from top500 t inner join "
sql+="(select system_id,name from system where name like '$name') s "
sql+="on t.system_id=s.system_id order by t.time asc"

$sqlite "$sql"

