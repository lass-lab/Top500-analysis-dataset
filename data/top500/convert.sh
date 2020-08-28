#!/bin/bash

outdir="csv"

for f in xls/*.xls; do
    tmpfile="tmp/`basename $f .xls`.csv"
    outfile="$outdir/`basename $f .xls`.csv"
    convertxls2csv -x $f -c $tmpfile

    cat $tmpfile | awk 'BEGIN { FPAT = "([^, ]*)|(\"[^\"]+\")"; OFS=":"}; {$1=$1; print $0}' > $outfile
done

