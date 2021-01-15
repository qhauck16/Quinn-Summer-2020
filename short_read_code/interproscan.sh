#!/bin/bash
#takes in an unprocessed transdecoder pep file and outputs an interproscan results


prot=$1
out=$(basename ${1})
sed 's/\*//g' $prot > ${out}_clean.pep

JAVA=~/repos/my_interproscan/jdk-11.0.7/bin/java
/home/gmoney/repos/my_interproscan/interproscan-5.44-79.0/interproscan.sh -cpu 28 -d . -goterms -iprlookup -pa -i ${out}_clean.pep -f tsv
