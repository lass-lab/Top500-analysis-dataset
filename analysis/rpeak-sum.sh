#!/bin/bash

for file in linpack/rpeak/*.csv; do
    time="`basename $file .csv`"

    echo -n "$time,"
    Rscript -e 'd<-scan("stdin", quiet=TRUE); cat(mean(d),quantile(d),"\\n");' < $file | \
        gsed 's/ /,/g' | gsed 's/,$//'
done

