#!/bin/bash

## getting the list of the top5 machines since 2009
top="5"

sqlite="sqlite3 ../scrap500.db -csv"

sql="select time,rank,system_id from top500 "
sql+="where time >= 200900 and rank <= 5"

$sqlite "$sql"

