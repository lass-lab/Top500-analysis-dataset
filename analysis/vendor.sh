#!/bin/bash

sqlite="sqlite3 scrap500.db -csv"
sql="select manufacturer,count(id) as count from system group by manufacturer order by count(id) desc"

$sqlite "$sql"

