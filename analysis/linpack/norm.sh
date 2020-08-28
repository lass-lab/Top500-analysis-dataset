#!/bin/bash

for file in rmax/*.csv; do
    time="`basename $file .csv`"
    max="`head -n1 $file`"
    cat $file | awk -v max=$max '{ printf "%.6f\n", $1/max }' \
	    > rmax-norm/${time}.csv
done

i=1

for file in rmax-norm/*.csv; do
    time="`basename $file .csv`"
    echo -n "$i,"
    Rscript -e 'd<-scan("stdin", quiet=TRUE); cat(mean(d),quantile(d),"\\n");' < $file | \
        gsed 's/ /,/g' | gsed "s/\$/$time/"
    i=$((i+1))
done

