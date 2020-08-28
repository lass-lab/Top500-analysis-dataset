#!/bin/bash

## $1: filename, $2: str
function getfno {
    nf=`head -n1 $1 | sed -e 's/\(.*\)/\L\1/' -e 's/,/\n/g' -e 's/\"//g' | \
             egrep -n ^$2$ | cut -d: -f1`
    echo $nf
}

outdir="rmax"

fname="rmax"

for y in `seq 1993 2016`; do
    for mo in 6 11; do
        m="`printf %02d $mo`"
        filename="csv/TOP500_${y}${m}.csv"
        fno="$(getfno $filename $fname)"
        #echo $fno

        outfile="$outdir/`basename $filename`"
        tail -n+2 $filename | awk "BEGIN { FPAT = \"([^, ]*)|(\"[^\"]+\")\" } {print \$$fno}" > $outfile
    done
done

exit

fname="rmax\ \[tflop\/s\]"

for y in `seq 2017 2018`; do
    for mo in 6 11; do
        m="`printf %02d $mo`"
        filename="csv/TOP500_${y}${m}.csv"
        fno=$(getfno $filename "$fname")
        #echo $fno

        outfile="$outdir/`basename $filename`"
        tail -n+2 $filename | awk \'BEGIN { FPAT = "([^, ]*)|(\"[^\"]+\")"  } {print \$$fno}\' > $outfile
    done
done
