#!/bin/bash

if [ $# -ne 1 ]; then
    echo "usage: $0 <attribute #>"
    echo "
    1|Cores
    2|Memory
    3|Processor
    4|Interconnect
    5|Linpack Performance (Rmax)
    6|Theoretical Peak (Rpeak)
    7|Nmax
    8|Nhalf
    9|HPCG [TFlop/s]
    10|Power
    11|Power Measurement Level
    12|Measured Cores
    13|Operating System
    14|Compiler
    15|Math Library
    16|MPI"
    echo

    exit 1
fi

attr=$1

case $attr in
    [3-4])
        vf="sval"
        ;;
    1[3-6])
        vf="sval"
        ;;
    *)
        vf="rval"
        ;;
esac

no1sysid=(`cat no1.csv | cut -d, -f1`)

for sysid in ${no1sysid[@]}; do
    sql="select $vf from sysattr_val where system_id=$sysid and nid=$attr;"
    echo -n "$sysid,"
    sqlite3 -csv scrap500.db "$sql"
done
