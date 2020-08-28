#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: <YYYYMM> <attribute #>"
    echo
    echo "Attribute #: "
    cat attributes-index.csv
    echo
    exit 1
fi

file="TOP500_${1}.csv"

if [ ! -f "$file" ]; then
    echo "$file does not exist"
    exit 1
fi

attr="`cat attributes-index.csv | awk "/^${2}\t/" | egrep -o '[A-Z].*$'`"
export attr

cn_computer="`head -n1 $file | gsed 's/"//g' | awk -F: '{for(i=1;i<=NF;++i){if($i=="Computer")print i}}'`"
cn_attr="`head -n1 $file | gsed 's/"//g' | awk -F: '{for(i=1;i<=NF;++i){if($i==ENVIRON["attr"])print i}}'`"

# for debug
echo $attr,$cn_computer,$cn_attr
head -n1 $file | gsed 's/:/\n/g' | awk '{print NR": "$0}'

export cn_computer
export cn_attr

printf "Rank %20s %s\n" Computer #$attr
tail -n+2 $file | gsed 's/"//g' | awk -F: '{printf("%4d %20s\n",$1,$7)}'
#tail -n+2 $file | gsed 's/"//g' | awk -F: '{printf("%4d %20s %s\n",$1,$ENVIRON["cn_computer"],$ENVIRON["cn_attr"])}'

