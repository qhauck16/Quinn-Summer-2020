#!/bin/bash
#runs on an input file of gene ids (first variable) and subsets an input gtf file (second variable) by gene id

awk -F'"' 'FNR==NR {block[$0];next} $4 in block' $1 $2 > $3
