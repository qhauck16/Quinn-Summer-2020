#!/bin/bash

#This is a script to create a new text file with the Mapq scores from a .bam file
#Script takes two inputs: input file and destination file


echo "pulling mapQ scores..."
samtools view $1 | awk -F '\t' '{print $5}' > $2
