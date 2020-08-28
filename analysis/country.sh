#!/bin/bash

sqlite="sqlite3 scrap500.db -csv"
sql="select country,count(id) as count from site group by country order by count desc;"

$sqlite "$sql"

