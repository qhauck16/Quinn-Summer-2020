#!/bin/bash

echo "pulling gene identifier and uniprot IDs from" $1

awk -F "\t" '{print $1 " " $5}' $1 > $2 
