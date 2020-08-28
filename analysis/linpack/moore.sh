#!/bin/bash

## rmax

base="`head -n1 rmax.csv | awk -F, '{print $NF}'`"
cat rmax.csv | gawk -v base="$base" -F, \
	'{ val=1.0*base*(2^((NR-1)/2.0)); printf "%s,%.6f,%.6f\n", $1, val, $NF}' \
	| tee moore-rmax.csv


## rpeak

base="`head -n1 rpeak.csv | awk -F, '{print $NF}'`"
cat rpeak.csv | gawk -v base="$base" -F, \
	'{ val=1.0*base*(2^((NR-1)/2.0)); printf "%s,%.6f,%.6f\n", $1, val, $NF}' \
	| tee moore-rpeak.csv

