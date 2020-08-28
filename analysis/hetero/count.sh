#!/bin/bash

seq=1

for file in *.csv; do
  name="`basename $file .csv`"
  c1=`cat $file | egrep -v None | wc -l`
	c2=`cat $file | egrep '^[1-9][0-9]*$' | wc -l`

	if [ $c1 -eq 500 ]; then
    c1=0
	fi

	cnt=$((c1+c2))
	ratio=`python -c "print 1.0*$cnt/500"`
	echo $seq,$name,$cnt,500,$ratio

	((seq++))
done

exit 0
