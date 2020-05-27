#!/bin/bash

#Pulls read lengths from nanopore sequencing summary file

echo 'Pulling read lengths from ' $1 'to' $2

awk -F '\t' '{print $14}' $1 > $2
