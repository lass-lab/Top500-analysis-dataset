#!/bin/bash

sqlite="sqlite3 scrap500.db -csv"

sql="select system_id,max(rval) from sysattr_val "
sql+="where nid=5 "
sql+="group by system_id"

$sqlite "$sql"
