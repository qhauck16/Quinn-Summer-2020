#!/bin/bash

echo "Pulling gene idenitifiers from" $1

awk -F "\t" '{print $1}' $1 > $2
