#!/bin/bash
##takes in a pep file from transdecoder along with a file of transcript IDs (variable 1) and filters the pep file on it
seqkit grep -r -f $1 $2 > $3
