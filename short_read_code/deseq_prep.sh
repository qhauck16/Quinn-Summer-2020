#!/bin/bash 
#takes in a prepde.py output file (specifically aliana annotation) and saves only important gene names, outputs to $2

cat $1 | awk -v RS='\r\n' -F '|' '{print $2}' > $2
